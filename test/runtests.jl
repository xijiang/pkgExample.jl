println("Testing pkgExample ...")

using Test

@test pkgExample.plusone(17) == 18
