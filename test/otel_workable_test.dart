// Licensed under the Apache License, Version 2.0
// Copyright 2025, Mindful Software LLC, All rights reserved.

import 'package:otel_workable/otel_workable.dart';
import 'package:test/test.dart';

void main() {
  group('otel_workable', () {
    test('suppression toggles in zone', () async {
      expect(workableInstrumentationSuppressed(), isFalse);
      await runWithoutWorkableInstrumentationAsync(() async {
        expect(workableInstrumentationSuppressed(), isTrue);
      });
      expect(workableInstrumentationSuppressed(), isFalse);
    });

    test('WorkableResult fields default null', () {
      const r = WorkableResult();
      expect(r.jobId, isNull);
      expect(r.candidateId, isNull);
      expect(r.applicationState, isNull);
    });
  });
}
