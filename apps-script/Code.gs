/**
 * Prepare for Peace contact form handler.
 *
 * Paste this into Extensions > Apps Script on a Google Sheet.
 * Set two Script properties (Project Settings > Script properties):
 *   TURNSTILE_SECRET  your Cloudflare Turnstile secret key
 *   NOTIFY_EMAIL      where messages are sent, eg ben@prepareforpeace.org.uk
 * Then Deploy > New deployment > Web app
 *   Execute as: Me
 *   Who has access: Anyone
 */

var SHEET_NAME = 'Messages';

function doPost(e) {
  try {
    var p = (e && e.parameter) || {};

    // Honeypot: real people never see this field. Pretend success so bots learn nothing.
    if (p.website) {
      return json({ ok: true });
    }

    var name = clean(p.name, 200);
    var email = clean(p.email, 200);
    var message = clean(p.message, 5000);

    if (!name || !email || !message) {
      return json({ ok: false, error: 'Please fill in your name, email and message.' });
    }
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
      return json({ ok: false, error: 'Please check your email address.' });
    }

    if (!verifyTurnstile(p['cf-turnstile-response'])) {
      return json({ ok: false, error: 'The security check failed. Please try again.' });
    }

    saveToSheet([new Date(), name, email, message]);

    var to = PropertiesService.getScriptProperties().getProperty('NOTIFY_EMAIL');
    MailApp.sendEmail({
      to: to,
      replyTo: email,
      subject: 'Prepare for Peace: message from ' + name,
      body: 'Name: ' + name + '\nEmail: ' + email + '\n\n' + message
    });

    return json({ ok: true });
  } catch (err) {
    console.error(err);
    return json({ ok: false, error: 'Something went wrong on our side. Please email us instead.' });
  }
}

function doGet() {
  return ContentService.createTextOutput('Prepare for Peace contact form endpoint.');
}

function verifyTurnstile(token) {
  if (!token) return false;
  var secret = PropertiesService.getScriptProperties().getProperty('TURNSTILE_SECRET');
  var res = UrlFetchApp.fetch('https://challenges.cloudflare.com/turnstile/v0/siteverify', {
    method: 'post',
    payload: { secret: secret, response: token },
    muteHttpExceptions: true
  });
  var data = JSON.parse(res.getContentText());
  return data.success === true;
}

function saveToSheet(row) {
  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var sheet = ss.getSheetByName(SHEET_NAME);
  if (!sheet) {
    sheet = ss.insertSheet(SHEET_NAME);
    sheet.appendRow(['Received', 'Name', 'Email', 'Message']);
    sheet.setFrozenRows(1);
  }
  sheet.appendRow(row.map(safeCell));
}

// Trim, cap length, and strip control characters.
function clean(value, max) {
  return String(value || '').replace(/[\u0000-\u0008\u000B\u000C\u000E-\u001F]/g, '').trim().slice(0, max);
}

// Stop anything that looks like a spreadsheet formula from running.
function safeCell(v) {
  if (typeof v === 'string' && /^[=+\-@]/.test(v)) return "'" + v;
  return v;
}

function json(obj) {
  return ContentService.createTextOutput(JSON.stringify(obj)).setMimeType(ContentService.MimeType.JSON);
}

// Run this once from the editor to authorise mail and sheet access before deploying.
function authorise() {
  SpreadsheetApp.getActiveSpreadsheet();
  MailApp.getRemainingDailyQuota();
  UrlFetchApp.fetch('https://challenges.cloudflare.com');
}
