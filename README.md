# Little Help Book API

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]
[![Powered by Dart Frog](https://img.shields.io/endpoint?url=https://tinyurl.com/dartfrog-badge)](https://dartfrog.vgv.dev)

This is a simple backend application built with [Dart Frog](https://dartfrog.vgv.dev). The purpose of this project is to expose an API to a cross-platform mobile app. To start, the API will integrate with Airtable in order to access existing datastores. As development proceeds, the data will be ingested, normalized, and persisted in a new database (TBD).

## Getting Started

For more information on getting started with Dart Frog, please review the official [documentation](https://dartfrog.vgv.dev/docs/overview). To run this app, clone the repo, install `dart_frog` CLI, and start the server.

```sh
# Install the dart_frog cli from pub.dev
dart pub global activate dart_frog_cli

# Start the server:
dart_frog dev
```

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
