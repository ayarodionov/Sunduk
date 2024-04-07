using Sunduk
using Test


@testset "Simple tests" begin
    "Hello World!    " == to_string(to_matrix(str_to_int("Hello World!"), 4,4))
end