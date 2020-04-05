println("Testing pkgExample ...")

using Test, pkgExample

@test pkgExample.plusone(17) == 18
