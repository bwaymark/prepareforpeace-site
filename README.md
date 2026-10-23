# Prepare for Peace website

A small static site hosted free on GitHub Pages. Page text is written in Markdown, so you can edit it in the browser on github.com, including from your phone. The contact form uses Cloudflare Turnstile for spam protection and a Google Apps Script that saves each message to a Google Sheet and emails it to you.

## What is in this folder

| File | What it does |
| --- | --- |
| `index.md` | The home page: the article. Edit this to change the text. |
| `get-involved.md` | The "How can I get involved?" page, with the list of people we are looking for. |
| `be-ready.md`, `food.md`, `radio.md`, `low-tech.md` (the Word of mouth page), `health.md`, `community.md` | The section pages. Each lists the guides we plan to write. |
| `amateur-radio.md` | The amateur (ham) radio guide, a sub-page of Radio at `/radio/amateur/`. |
| `meshtastic.md` | The Meshtastic and LoRa guide, a sub-page of Radio at `/radio/meshtastic/`. |
| `cb-radio.md` | The CB radio guide, a sub-page of Radio at `/radio/cb/`. |
| `pmr446.md` | The PMR446 guide, a sub-page of Radio at `/radio/446/`. |
| `first-aid.md` | First aid for people, a sub-page of Health at `/health/first-aid/`. |
| `pet-first-aid.md` | First aid for pets, a sub-page of Health at `/health/pet-first-aid/`. |
| `food-growing.md`, `food-preserving.md`, `food-animals.md`, `food-pest-control.md`, `food-cooking-at-scale.md` | The Food sub-pages, under `/food/`. |
| `kit-list.md` | The kit list, a sub-page of Be ready at `/be-ready/kit-list/`. |
| `books.md` | The Further reading page: recommended websites and books. Add every website we link to from other pages here too. |
| `about.md` | The About us page. |
| `licence.md` | The licence page (CC BY-SA 4.0). |
| `disclaimer.md` | The disclaimer page. |
| `_data/footer.yml` | The footer menu. |
| `_data/navigation.yml` | The main menu: the order and wording of the menu items. |
| `_includes/peacemakers.html` | The "Peacemakers on every channel" box used on the communication pages. Add it to any page with `{% include peacemakers.html %}`. |
| `_includes/help-wanted.html` | The "we are looking for people" box shown at the bottom of each section page. |
| `privacy.md` | The privacy notice linked from the form. |
| `_config.yml` | Site title, email address, and the two form settings. |
| `_layouts/default.html` | The page template: header, logo, menu and footer. |
| `_includes/contact.html` | The contact form. |
| `assets/style.css` | Colours, fonts and layout. |
| `assets/logo.svg` | The logo shown in the header. |
| `assets/favicon.svg` | The small icon shown in browser tabs. |
| `assets/icon-180.png`, `assets/icon-512.png` | Icons for phone home screens and link previews. |
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
- To change the list of people we are looking for, edit `get-involved.md`. Each person or role is one line starting with `- `.
- To add a guide to a section, replace the line `<p class="soon">Guides coming soon.</p>` with links to the guides, or turn an item in the list into a link: `- [A household plan](/be-ready/household-plan/)`.
- To add a page, create a new file such as `guides.md` that starts with the same header used in `privacy.md` (the lines between the two `---` lines). Change the `title` and `permalink`. It will appear at the permalink, for example `/guides/`.
- To add the contact form to a page, put `{% include contact.html %}` on its own line where you want the form to appear.
- To add a sub-page to a section, create the page with a permalink inside the section (for example `/food/growing/`), then list it under `children:` for that section in `_data/navigation.yml`, as the Kit list is under Be ready. It then appears in the menu dropdown, the sidebar and the "In this section" bar.
- To change the footer menu, edit `_data/footer.yml` in the same way.
- To add, remove or reorder menu items, edit `_data/navigation.yml`. Each item has a `title` (the words in the menu) and a `url` (the page's permalink).
- To change colours, edit the values at the top of `assets/style.css`.

## Logo and colours

The logo is a circle with a gap and a single dot stepping into it. It stands for making room for others so that no one is left outside. The colours are:

| Use | Colour |
| --- | --- |
| Main green | `#2f6b5a` |
| Accent amber | `#c8873a` |
| Background cream | `#faf8f4` |
| Text | `#24221f` |

Use `assets/icon-512.png` as the profile picture for any social media accounts.

## Previewing changes before you publish

You can run the site on your own computer and check it at http://localhost:4000 before uploading anything to GitHub. `Gemfile` and `_config.dev.yml` are only used for this; the live site ignores them.

### With Docker (simplest if you already have Docker)

From inside the site folder, run:

```
docker run --rm -it -v "$PWD":/site -w /site -p 4000:4000 ruby:3.3 \
  bash -c "bundle install && bundle exec jekyll serve --host 0.0.0.0 --livereload --config _config.yml,_config.dev.yml"
```

The first run takes a few minutes while it installs Jekyll. Then open http://localhost:4000. Leave it running while you edit: the page reloads by itself each time you save a file. Press Ctrl+C to stop.

### Without Docker

1. Install Ruby: on a Mac use `brew install ruby`; on Windows use RubyInstaller (the version with Devkit); on Linux use your package manager.
2. In the site folder, run `bundle install` once.
3. Run `bundle exec jekyll serve --livereload --config _config.yml,_config.dev.yml` and open http://localhost:4000.

### What the preview cannot test

The preview uses Cloudflare's test key, so the security check always passes, but messages will not be delivered. Test the contact form on the live site after publishing.

### A tidier way to publish

Instead of uploading files in the browser, clone the repository with GitHub Desktop (or `git clone`), edit and preview in that folder, then commit and push. Only the files you changed are sent, and GitHub keeps a history so you can undo a mistake.

## Helper scripts (Mac)

Run these from Terminal in the site folder. Run `chmod +x runMe.zsh publish.zsh` once to make them runnable.

- `./runMe.zsh` copies the newest download from your Downloads folder into the site (never touching `_config.yml`) and starts the preview at http://localhost:4000.
- `./publish.zsh` checks the site builds, asks you to describe your changes, then commits them and pushes them to GitHub. It stops if `_config.yml` still contains a placeholder key.

`.gitignore` stops the files Jekyll builds on your computer (such as `_site/`) from being uploaded.
