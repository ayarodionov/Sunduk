module Sunduk
# import Pkg
# Pkg.add("Mods")
# https://github.com/scheinerman/Mods.jl

using Mods
import Base.Char

export 
    mod_to_str, 
    to_matrix, 
    str_to_int, 
    to_string, 
    str_to_matrix,
    matrix_to_str,
    example

"Fixes size of input vector to make it fit matrix m*n"
function fix_size(v, m, n) 
    d = m * n
    l =  length(v)
    if l > d
        v[1:d]
    elseif d > l
        [v; fill(32, d - l)]
    else v
    end
end

"Creates a character from a Mod type number"
Char(a::Mod) = Char(a.val)

"Creates m*n matrix from vector v"
to_matrix(v, m, n) = reshape(fix_size(v, m, n), m, n)

# to_vector(m) = vec(m)
"Creates string form integer vector"
to_string(m) = mod_to_str(vec(m))

"Creates integer vector from string"
str_to_int(str) = [Int(s) for s in str]
# str_to_int("Hello World!")

"Creates string vrom vector of Mod numbers"
mod_to_str(v) = String([Char(n) for n in v])
# mod_to_str(str_to_int("Hello World!"))


# julia> to_string(to_matrix(str_to_int("Hello World!"), 4,4))
# "Hello World!    "

calc_dim(m) = ceil(Int, sqrt(m)) + 1

"Creates integer m*n matrix from string"
str_to_matrix(str) = str_to_matrix(str, calc_dim(length(str)))

str_to_matrix(str, m) = str_to_matrix(str, m, m) 

str_to_matrix(str, m, n) = to_matrix(str_to_int(str), m, n) 

"Creates string from matrix"
matrix_to_str(m) = mod_to_str(vec(m))

function drazin(A, D, n)
    for i=1:n
        D = D + D*(I - A*D)
    end
    return D, A*D
end

function example(str)
    println("Initial message: $str")
    Message= str_to_matrix(str)
    m, n = size(Message)
    BobtoAlise = matrix_to_str(Message)
    println("Bob sent to Alise: \"$BobtoAlise\"")
    L = rand(Mod{131},m,n)
    L1=inv(L)
    R = rand(Mod{131},m,n)
    R1=inv(R)
    S1 = L * Message
    AliseReceived = matrix_to_str(S1)
    println("Alise received: \"$AliseReceived\"")
    S2 = S1 * R
    BobReceived = matrix_to_str(S2)
    println("Bob received: \"$BobReceived\"")
    S3 = L1 * S2
    AliseReceived = matrix_to_str(S3)
    println("Alise received: \"$AliseReceived\"")
    S4 = S3 * R1
    AliseDecoded = matrix_to_str(S4)
    println("Alise decoded: \"$AliseDecoded\"")
end

# julia> example("Hello Julia!!!")
# Initial message: Hello Julia!!!
# Bob sent to Alise: "Hello Julia!!!           "
# Alise received: "S
# =dJocrt:.jZ/(*Z/(*"
# Bob received: "[r )850'i$Q';	aQUV9sv0>
# Alise received: "'oAb?AxHHqOfr
#                               (`K4sg"
# Alise decoded: "Hello Julia!!!           "



end # module Sunduk
