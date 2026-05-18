// Licensed under the Dartastic Pro Software License Agreement.
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

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
