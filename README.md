# WordPress PHP service for Wodby

Build and run WordPress applications on Kubernetes with
[Wodby](https://wodby.com). This repository contains the `service.yml` manifest
and `Dockerfile` used by the public WordPress PHP service in the Wodby catalog.

- [WordPress PHP service in the Wodby catalog](https://wodby.com/services/wordpress-php)
- [Wodby service documentation](https://wodby.com/docs/2.0/services/)
- [Service manifest reference](https://wodby.com/docs/2.0/services/template/)

## What it provides

| Feature | Default configuration |
| --- | --- |
| PHP runtime | Inherits from the Wodby [`php`](https://github.com/wodby/service-php) service |
| PHP versions | PHP 8.5 by default, with PHP 8.2, 8.3, and 8.4 available |
| Application build | Connects a Git repository, copies the source into the WordPress PHP image, and runs the standard WordPress initialization |
| Starter project | [Vanilla WordPress](https://github.com/wodby/wordpress-vanilla) |
| Document root | `web` by default; configurable at build time |
| WordPress files | Required shared storage link with a 10 GB `wp-content` volume |
| Database | Required database link inherited from the PHP service |
| Object cache | Optional Redis or Valkey link |
| Email | Optional mail transfer agent link inherited from the PHP service |
| WordPress secrets | Generated authentication keys and salts |
| Cron | Runs due WordPress cron events daily at midnight |

The service deploys a primary `main` workload with a buildable `php` container
based on the `wodby/wordpress-php` image. The linked `wp-content` volume is
shared and supports file imports with the WordPress container ownership.

## Use this service

A service is a reusable component and does not deploy by itself. Add the public
WordPress PHP service to a stack, or use the
[public WordPress stack](https://wodby.com/stacks/wordpress), which already
connects it to Nginx, a database, shared storage, mail, and cache services.

To maintain your own version of the service:

1. Fork this repository.
2. Edit [`service.yml`](service.yml) and the [`Dockerfile`](Dockerfile) as
   needed.
3. Import the repository as a
   [Git-backed service](https://wodby.com/docs/2.0/services/create/#create-a-git-backed-service).
4. Reference the imported service from your stack manifest.

Wodby imports the manifest and referenced build files from the selected Git
branch or tag and creates a new service revision when the Git-backed service is
updated.

## Customize the service

Common changes include:

- changing the available or default PHP versions;
- replacing the starter project;
- changing the default document root or WordPress initialization steps;
- adjusting shared storage and cron defaults; and
- adding WordPress-specific settings, links, or environment variables.

Keep the `main` workload and `php` container names stable unless dependent
stacks are updated at the same time. Stack and app-level overrides can refer to
these names directly.

Validate a customized manifest with the Wodby CLI before importing it:

```bash
wodby service validate-manifest service.yml --org <org-id>
```

See the [service manifest reference](https://wodby.com/docs/2.0/services/template/)
for every supported field and the [managed services
index](https://github.com/wodby/services) for more service examples.
