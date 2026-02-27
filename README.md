# Deploy Mattermost on Clever Cloud

This guide will help you deploy Mattermost on Clever Cloud using PostgreSQL and Cellar (S3-compatible storage).

## Prerequisites

- A Clever Cloud account
- Clever Cloud CLI installed ([documentation](https://www.clever.cloud/developers/doc/cli/))
- Git

## Required Add-ons

You’ll need to create and link the following add-ons to your application:

1. **PostgreSQL** - for database storage
2. **Cellar** - for file storage (S3-compatible)

## Quick Deploy

### 1. Fork and clone this repository

```
git clone https://github.com/YOUR-USERNAME/mattermost-clever-cloud.git
cd mattermost-clever-cloud
```

### 2. Create a Clever Cloud application

```
clever create --type magic mattermost-app
clever scale --flavor S
```

### 3. Link the add-ons

```
# Create and link PostgreSQL
clever addon create postgresql-addon mattermost-db --plan xxs_sml --link mattermost-app

# Create and link Cellar
clever addon create cellar-addon mattermost-storage --link mattermost-app
```

### 4. Configure environment variables

Set the required environment variables:

```
# Build configuration
clever env set CC_BUILD_COMMAND "echo \"No build needed\""
clever env set CC_PRE_BUILD_HOOK "bash clevercloud/pre_build.sh"
clever env set CC_RUN_COMMAND "bash start.sh"

# Application configuration (replace with your actual domain)
clever env set SITE_URL "<YOUR_APP_URL>"
clever env set CELLAR_BUCKET "mattermost-files"
```

**Note**: You can find your Clever Cloud app domain in the console or with `clever domain`

### 5. (Optional) Configure SMTP for email notifications

```
clever env set MM_EMAILSETTINGS_SMTPSERVER "smtp.example.com"
clever env set MM_EMAILSETTINGS_SMTPPORT "587"
clever env set MM_EMAILSETTINGS_SMTPUSERNAME "your-username"
clever env set MM_EMAILSETTINGS_SMTPPASSWORD "your-password"
clever env set MM_EMAILSETTINGS_CONNECTIONSECURITY "STARTTLS"
clever env set MM_EMAILSETTINGS_FEEDBACKNAME "Mattermost"
clever env set MM_EMAILSETTINGS_FEEDBACKEMAIL "noreply@yourdomain.com"
clever env set MM_EMAILSETTINGS_REPLYTOADDRESS "support@yourdomain.com"
clever env set MM_SUPPORTSETTINGS_SUPPORTEMAIL "support@yourdomain.com"
```

### 6. Deploy

```
clever deploy
```

Your Mattermost instance will be available at your Clever Cloud app URL in a few minutes! 🎉

## Project Structure

```
mattermost-clever-cloud/
├── clevercloud/
│   └── pre_build.sh        # Downloads and extracts Mattermost
├── start.sh                 # Starts Mattermost with configuration
├── .gitignore               # Excludes downloaded files
└── README.md
```

## Environment Variables Reference

### Build & Run Commands (Required):

- `CC_BUILD_COMMAND` - Set to `echo "No build needed"`
- `CC_PRE_BUILD_HOOK` - Set to `bash clevercloud/pre_build.sh`
- `CC_RUN_COMMAND` - Set to `bash start.sh`

### Application Configuration (Required):

- `SITE_URL` - Your Mattermost public URL (e.g., `https://your-app.cleverapps.io`)
- `CELLAR_BUCKET` - Your Cellar bucket name for file storage

### Optional (SMTP Email):

- `MM_EMAILSETTINGS_SMTPSERVER` - SMTP server address
- `MM_EMAILSETTINGS_SMTPPORT` - SMTP port (usually 587 or 465)
- `MM_EMAILSETTINGS_SMTPUSERNAME` - SMTP username
- `MM_EMAILSETTINGS_SMTPPASSWORD` - SMTP password
- `MM_EMAILSETTINGS_CONNECTIONSECURITY` - Security type (STARTTLS, TLS, or SSL)
- `MM_EMAILSETTINGS_FEEDBACKEMAIL` - From email address
- `MM_EMAILSETTINGS_REPLYTOADDRESS` - Reply-to email address
- `MM_SUPPORTSETTINGS_SUPPORTEMAIL` - Support email address

### How it works

1. **Pre-build phase**: The `pre_build.sh` script downloads and extracts Mattermost binary (version 9.11.3)
2. **Build phase**: Skipped (nothing to build)
3. **Run phase**: The `start.sh` script configures and starts Mattermost with environment variables

## Support

For issues or questions:

- [Clever Cloud documentation](https://www.clever.cloud/developers/doc/)
- [Mattermost documentation](https://docs.mattermost.com/index.html)
