from django.test import TestCase

class SmokeTest(TestCase):
    def test_smoke(self):
        self.assertEqual(True, True)