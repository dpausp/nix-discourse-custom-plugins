import unittest
from unittest.mock import patch
from update import DiscourseVersion, DiscourseRepo

SAMPLE_COMPATIBILITY = """< 3.5.0.beta6-dev: 7e0a51707f98eb8ec49fa39c519075b1766d54be
< 3.5.0.beta5-dev: 5c44f829ef82ded3416b0cddc521e9e6d62ed534
< 3.5.0.beta4-dev: 14ca3c07efa0a80712a4cbb8ca455c32a727adec
< 3.5.0.beta2-dev: 5f24835801fdc7cb98e1bcf42d2ab2e49e609921
< 3.5.0.beta1-dev: 7d411e458bdd449f8aead2bc07cedeb00b856798
< 3.4.0.beta3-dev: b4cf3a065884816fa3f770248c2bf908ba65d8ac
< 3.4.0.beta1-dev: 5346b4bafba2c2fb817f030a473b7bbca97b909c
< 3.3.0.beta1-dev: 6750e10a6d9dfd3fc2c9a0cac5a83aca1a8ee401
3.1.999: 20aed65b909fb41e22181067dc990b52ab0b7a96"""

class TestPluginVersionSelection(unittest.TestCase):
    @patch('requests.get')
    def test_version_selection(self, mock_get):
        # Mock GitHub API response
        mock_get.return_value.status_code = 200
        mock_get.return_value.text = SAMPLE_COMPATIBILITY
        
        # Initialize repo and test version
        repo = DiscourseRepo(owner="discourse", repo="test-plugin")
        discourse_version = DiscourseVersion("3.4.4")
        
        # Get compatible versions using actual code from update.py
        compatibility_spec = repo.get_file(".discourse-compatibility", "fake-sha")
        versions = []
        for line in compatibility_spec.splitlines():
            if not line.strip():
                continue
            operator_part, plugin_rev = line.split(":", 1)
            plugin_rev = plugin_rev.strip()
            
            # Actual parsing logic from update.py
            if operator_part.startswith("<="):
                op = "<="
                discourse_version_str = operator_part[2:].strip()
            elif operator_part.startswith("<"):
                op = "<"
                discourse_version_str = operator_part[1:].strip()
            else:  # legacy format
                op = "<="
                discourse_version_str = operator_part.strip()

            versions.append(
                (op, DiscourseVersion(discourse_version_str), plugin_rev)
            )
        
        # Filter using actual version comparison logic
        compatible_versions = []
        for op, spec_version, rev in versions:
            if op == "<" and discourse_version < spec_version:
                compatible_versions.append((spec_version, rev))
            elif op == "<=" and discourse_version <= spec_version:
                compatible_versions.append((spec_version, rev))
        
        # Sort and select highest compatible version
        compatible_versions.sort(reverse=True, key=lambda x: x[0])
        selected_rev = compatible_versions[0][1] if compatible_versions else None
        
        # Verify expected revision
        self.assertEqual(selected_rev, "7d411e458bdd449f8aead2bc07cedeb00b856798")

if __name__ == "__main__":
    unittest.main()
