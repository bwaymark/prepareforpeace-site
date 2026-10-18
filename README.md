# Prepare for Peace website

A small static site hosted free on GitHub Pages. Page text is written in Markdown, so you can edit it in the browser on github.com, including from your phone. The contact form uses Cloudflare Turnstile for spam protection and a Google Apps Script that saves each message to a Google Sheet and emails it to you.

## What is in this folder

| File | What it does |
| --- | --- |
| `index.md` | The holding page: the article. Edit this to change the text. |
| `privacy.md` | The privacy notice linked from the form. |
| `_config.yml` | Site title, email address, and the two form settings. |
| `_layouts/default.html` | The page template (header, footer). |
| `_includes/contact.html` | The contact form. |
| `assets/style.css` | Colours and fonts. |
| `CNAME` | Tells GitHub Pages to use prepareforpeace.org.uk. |
| `apps-script/Code.gs` | Form handler to paste into Google Apps Script. Not published. |

## Setting it up

### 1. Put the files on GitHub

1. Sign in at github.com and create a new public repository called `prepareforpeace-site`. Leave "Add a README" unticked.
2. On the empty repository page, click "uploading an existing file".
3. Drag in everything from this folder, keeping the folder structure, and click "Commit changes".

### 2. Turn on GitHub Pages

1. In the repository, go to Settings, then Pages.
2. Under "Build and deployment", set Source to "Deploy from a branch", branch `main`, folder `/ (root)`. Save.
3. After a minute or two the site appears at `https://<your-username>.github.io/prepareforpeace-site/`.

### 3. Point the domain at it

At the registrar where prepareforpeace.org.uk is registered, open the DNS settings. Do not touch the existing MX and TXT records, because Google Workspace needs them for email.

1. Add four A records for the bare domain (host `@`):
   - `185.199.108.153`
   - `185.199.109.153`
   - `185.199.110.153`
   - `185.199.111.153`
2. Add a CNAME record for `www` pointing to `<your-username>.github.io`.
3. In GitHub, Settings, Pages, enter `prepareforpeace.org.uk` as the custom domain if it is not already there.
4. Once the DNS check passes (from a few minutes up to a day), tick "Enforce HTTPS".
5. Recommended: verify the domain in your GitHub account settings (Settings, Pages, "Add a domain"). This stops anyone else claiming it on GitHub.

### 4. Create the security check (Cloudflare Turnstile)

1. Create a free Cloudflare account. You do not need to move your domain to Cloudflare.
2. In the dashboard, open Turnstile and click "Add widget".
3. Name it "Prepare for Peace", add the hostnames `prepareforpeace.org.uk` and `www.prepareforpeace.org.uk`, and choose "Managed" mode.
4. Copy the site key and the secret key.

### 5. Set up the form handler (Google Sheet and Apps Script)

1. In Google Drive, signed in as the Workspace account, create a Google Sheet called "Prepare for Peace messages".
2. In the sheet, go to Extensions, then Apps Script. Delete the sample code and paste in everything from `apps-script/Code.gs`. Save.
3. Click the cog (Project Settings) and, under Script properties, add:
   - `TURNSTILE_SECRET`: the secret key from step 4
   - `NOTIFY_EMAIL`: `ben@prepareforpeace.org.uk`
4. Back in the editor, choose the `authorise` function from the menu at the top and click Run. Accept the permission prompts.
5. Click Deploy, then New deployment. Choose type "Web app", set "Execute as" to Me and "Who has access" to Anyone. Click Deploy and copy the web app URL, which ends in `/exec`.

If you change the script later, use Deploy, then Manage deployments, and edit the existing deployment to a new version. That keeps the same URL.

### 6. Connect the form

1. On GitHub, open `_config.yml` and click the pencil icon.
2. Paste the Turnstile site key into `turnstile_sitekey` and the web app URL into `form_endpoint`.
3. Commit. The site rebuilds within a couple of minutes.

### 7. Test it

Send yourself a message through the form. Check that it appears in the sheet and arrives by email, and that clicking Reply goes to the sender.

## Editing the site later

- To change the text, open `index.md` on GitHub, click the pencil, edit, and commit. The text is Markdown: `## ` starts a heading and `- ` starts a bullet.
- To add a page, create a new file such as `guides.md` that starts with the same three-line header used in `privacy.md`. It will appear at `/guides/`.
- To change colours, edit the values at the top of `assets/style.css`.
