# otel_workable

Dartastic OpenTelemetry bridge for [Workable](https://workable.com), a recruiting / ATS platform.

Wraps each Workable API call in a CLIENT-kind span with attributes for jobs, candidates, applications, interviews, offers, and members.

```dart
import 'package:otel_workable/otel_workable.dart';

final candidate = await tracedWorkable<Candidate>(
  operation: 'createCandidate',
  invoke: () async {
    final c = await workableClient.createCandidate(...);
    return WorkableCallResult(
      value: c,
      result: WorkableResult(
        jobId: c.jobId,
        jobShortcode: c.jobShortcode,
        candidateId: c.id,
        candidateStage: c.stage,
        statusCode: 201,
      ),
    );
  },
);
```

Suppress instrumentation within a block:

```dart
await runWithoutWorkableInstrumentationAsync(() async {
  await workableClient.someInternalSync();
});
```
