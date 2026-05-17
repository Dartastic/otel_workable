# Changelog

## [0.1.0-beta.1-wip]

### Added

- Initial release.
- `tracedWorkable<T>(...)` — wraps a Workable API call in a CLIENT-kind
  span with attributes for job, candidate, application, interview, offer,
  and member resources.
- `rpc.system=workable`, `rpc.method=<operation>`.
- Zone-scoped suppression via `runWithoutWorkableInstrumentation()` /
  `Async()`.
