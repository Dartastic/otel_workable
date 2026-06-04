// Licensed under the Dartastic Pro Software License Agreement.
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';

import 'otel_workable_suppression.dart';

class WorkableResult {
  const WorkableResult({
    this.account,
    this.jobId,
    this.jobShortcode,
    this.jobTitle,
    this.jobState,
    this.jobDepartment,
    this.candidateId,
    this.candidateStage,
    this.applicationId,
    this.applicationState,
    this.interviewId,
    this.interviewState,
    this.offerId,
    this.offerState,
    this.memberId,
    this.statusCode,
    this.errorCode,
    this.errorMessage,
  });

  final String? account;
  final String? jobId;
  final String? jobShortcode;
  final String? jobTitle;
  final String? jobState;
  final String? jobDepartment;
  final String? candidateId;
  final String? candidateStage;
  final String? applicationId;
  final String? applicationState;
  final String? interviewId;
  final String? interviewState;
  final String? offerId;
  final String? offerState;
  final String? memberId;
  final int? statusCode;
  final String? errorCode;
  final String? errorMessage;
}

class WorkableCallResult<T> {
  const WorkableCallResult({required this.value, this.result});
  final T value;
  final WorkableResult? result;
}

Future<T> tracedWorkable<T>({
  required String operation,
  required Future<WorkableCallResult<T>> Function() invoke,
  Tracer? tracer,
}) async {
  if (workableInstrumentationSuppressed()) {
    final r = await invoke();
    return r.value;
  }
  final t = tracer ?? OTel.tracerProvider().getTracer('otel_workable');
  final span = t.startSpan('workable $operation', kind: SpanKind.client);
  try {
    span.addAttributes(
        OTel.attributes([OTel.attributeString('rpc.system', 'workable')]));
    span.addAttributes(
        OTel.attributes([OTel.attributeString('rpc.method', operation)]));
    final r = await invoke();
    final res = r.result;
    if (res != null) {
      if (res.account != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('workable.account', res.account!)]));
      }
      if (res.jobId != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('workable.job.id', res.jobId!)]));
      }
      if (res.jobShortcode != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString('workable.job.shortcode', res.jobShortcode!)
        ]));
      }
      if (res.jobTitle != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('workable.job.title', res.jobTitle!)]));
      }
      if (res.jobState != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('workable.job.state', res.jobState!)]));
      }
      if (res.jobDepartment != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString('workable.job.department', res.jobDepartment!)
        ]));
      }
      if (res.candidateId != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('workable.candidate.id', res.candidateId!)]));
      }
      if (res.candidateStage != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString('workable.candidate.stage', res.candidateStage!)
        ]));
      }
      if (res.applicationId != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString('workable.application.id', res.applicationId!)
        ]));
      }
      if (res.applicationState != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString(
              'workable.application.state', res.applicationState!)
        ]));
      }
      if (res.interviewId != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('workable.interview.id', res.interviewId!)]));
      }
      if (res.interviewState != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString('workable.interview.state', res.interviewState!)
        ]));
      }
      if (res.offerId != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('workable.offer.id', res.offerId!)]));
      }
      if (res.offerState != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('workable.offer.state', res.offerState!)]));
      }
      if (res.memberId != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('workable.member.id', res.memberId!)]));
      }
      if (res.statusCode != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeInt('http.response.status_code', res.statusCode!)]));
      }
      if (res.errorCode != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('workable.error.code', res.errorCode!)]));
      }
      final fail = res.errorCode != null ||
          (res.statusCode != null && res.statusCode! >= 400);
      if (fail) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString(
              ErrorResource.errorType.key, res.errorCode ?? 'workable.error')
        ]));
        span.setStatus(SpanStatusCode.Error, res.errorMessage);
      }
    }
    return r.value;
  } catch (e, st) {
    span.recordException(e, stackTrace: st);
    span.setStatus(SpanStatusCode.Error, e.toString());
    rethrow;
  } finally {
    span.end();
  }
}
