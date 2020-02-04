#!/usr/bin/env python3

import requests
import sys
import unittest

SERVER = "http://localhost:80/"

_verbose = False


class TestRests(unittest.TestCase):
    def testbasic(self):
        headers = {"Authorization": "authme"}
        object_id = "SRRTESTTEST"
        sdl = requests.get(
            SERVER + f"/ga4gh/drs/v1/objects/{object_id}", headers=headers
        )
        if _verbose:
            print(f"request returned {sdl.status_code}")
        ret = sdl.json()
        self.assertTrue("id" in ret)
        self.assertEqual(ret["id"], object_id)
        self.assertTrue("checksums" in ret)
        self.assertEqual(ret["checksums"][0]["type"], "md5")
        self.assertTrue("access_methods" in ret)
        amtype = ret["access_methods"][0]["type"]
        self.assertTrue(amtype in ["s3", "gs"])
        self.assertGreater(ret["size"], 200000)
        self.assertTrue(ret["self_uri"].startswith("http"))
        self.assertRegex(ret["created_time"], r"\d{4}-\d{2}-\d{2}T")


if __name__ == "__main__":
    _verbose = "--verbose" in sys.argv
    unittest.main()
