// Licensed under the Apache License, Version 2.0
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';
import 'package:otel_workable/otel_workable.dart';

/// Traces Workable calls with OpenTelemetry.
///
/// `otel_workable` depends on the OpenTelemetry API only, so the application
/// initializes an SDK once at startup. Wrap each Workable call in
/// [tracedWorkable]; the `invoke` callback makes the real call and reports what
/// came back, which is recorded on the span.
Future<void> main() async {
  await OTel.initialize(serviceName: 'workable-example');

  // Traces a Workable call.
  final workableId = await tracedWorkable<String>(
    operation: 'create',
    invoke: () async {
      // Make the Workable call here, then report what it returned.
      const id = 'workable_8f3a2c';
      return const WorkableCallResult(
          value: id,
          result: WorkableResult(
              account: 'example',
              jobId: 'job_8f3a2c',
              jobShortcode: 'example',
              jobTitle: 'example',
              jobState: 'active',
              jobDepartment: 'example',
              candidateId: 'candidate_8f3a2c',
              candidateStage: 'example',
              applicationId: 'application_8f3a2c',
              applicationState: 'active',
              interviewId: 'interview_8f3a2c',
              interviewState: 'active',
              offerId: 'offer_8f3a2c',
              offerState: 'active',
              memberId: 'member_8f3a2c',
              statusCode: 201,
              errorCode: 'example',
              errorMessage: 'example'));
    },
  );
  OTelLog.info('tracedWorkable create returned $workableId');

  // Calls that should not be traced, such as health checks, run inside
  // runWithoutWorkableInstrumentationAsync.
  await runWithoutWorkableInstrumentationAsync(
    () => tracedWorkable<String>(
      operation: 'create',
      invoke: () async {
        const id = 'workable_8f3a2c';
        return const WorkableCallResult(
            value: id,
            result: WorkableResult(
                account: 'example',
                jobId: 'job_8f3a2c',
                jobShortcode: 'example',
                jobTitle: 'example',
                jobState: 'active',
                jobDepartment: 'example',
                candidateId: 'candidate_8f3a2c',
                candidateStage: 'example',
                applicationId: 'application_8f3a2c',
                applicationState: 'active',
                interviewId: 'interview_8f3a2c',
                interviewState: 'active',
                offerId: 'offer_8f3a2c',
                offerState: 'active',
                memberId: 'member_8f3a2c',
                statusCode: 201,
                errorCode: 'example',
                errorMessage: 'example'));
      },
    ),
  );

  await OTel.shutdown();
}
