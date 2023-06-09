using SmoothNumbers
using Test

"""
Check that the two arguments have the same type and are equal (with `isequal`).
"""
⩦(x::T, y::T) where T = isequal(x, y)
⩦(_, _) = false

@testset "SmoothNumbers.jl" begin
    @testset "pratt($T)" for T in (Int16, UInt16, Int32, UInt32, Int64, UInt64)
        @test pratt(T, 0) ⩦ T[]
        @test pratt(T, -10) ⩦ T[]
        @test pratt(T, 10) ⩦ T[1, 2, 3, 4, 6, 8, 9, 12, 16, 18]
        # list taken from https://oeis.org/A003586/list
        @test pratt(T, 55) ⩦ T[
            1,2,3,4,6,8,9,12,16,18,24,27,32,36,48,54,64,72,
            81,96,108,128,144,162,192,216,243,256,288,324,384,
            432,486,512,576,648,729,768,864,972,1024,1152,
            1296,1458,1536,1728,1944,2048,2187,2304,2592,2916,
            3072,3456,3888]
    end
    
    @testset "with_bases" begin
        @test with_bases(UInt[2, 3], 1344)[end] ⩦ UInt(17991041643939889152)
    end

    @testset "with_bases($T)" for T in (Int16, UInt16)
        @test with_bases(T[2], 10) ⩦ T[1, 2, 4, 8, 16, 32, 64, 128, 256, 512]
        @test with_bases(T[2, 3], 10) ⩦ T[1, 2, 3, 4, 6, 8, 9, 12, 16, 18]
    end
    
    @testset "with_bases($T)" for T in (Int32, UInt32, Int64, UInt64)
        @test with_bases(T[2], 10) ⩦ T[1, 2, 4, 8, 16, 32, 64, 128, 256, 512]
        @test with_bases(T[2, 3], 10) ⩦ T[1, 2, 3, 4, 6, 8, 9, 12, 16, 18]
        @test with_bases(T[2, 3], 100)[end] ⩦ T(93312)
    end

    @testset "OEIS" begin
        # 3-smooth, https://oeis.org/A003586
        @test smooth(3, 55) ⩦ [
            1,2,3,4,6,8,9,12,16,18,24,27,32,36,48,54,64,72,
            81,96,108,128,144,162,192,216,243,256,288,324,384,
            432,486,512,576,648,729,768,864,972,1024,1152,
            1296,1458,1536,1728,1944,2048,2187,2304,2592,2916,
            3072,3456,3888]
        # 5-smooth, https://oeis.org/A051037
        @test smooth(5, 62) ⩦ [
            1,2,3,4,5,6,8,9,10,12,15,16,18,20,24,25,27,30,32,
            36,40,45,48,50,54,60,64,72,75,80,81,90,96,100,108,
            120,125,128,135,144,150,160,162,180,192,200,216,
            225,240,243,250,256,270,288,300,320,324,360,375,
            384,400,405]
        # 5-smooth, https://oeis.org/A002473
        @test smooth(7, 65) ⩦ [
            1,2,3,4,5,6,7,8,9,10,12,14,15,16,18,20,21,24,25,
            27,28,30,32,35,36,40,42,45,48,49,50,54,56,60,63,
            64,70,72,75,80,81,84,90,96,98,100,105,108,112,120,
            125,126,128,135,140,144,147,150,160,162,168,175,
            180,189,192]
        # 11-smooth, https://oeis.org/A051038
        @test smooth(11, 67) ⩦ [
            1,2,3,4,5,6,7,8,9,10,11,12,14,15,16,18,20,21,22,
            24,25,27,28,30,32,33,35,36,40,42,44,45,48,49,50,
            54,55,56,60,63,64,66,70,72,75,77,80,81,84,88,90,
            96,98,99,100,105,108,110,112,120,121,125,126,128,
            132,135,140]
        # 13-smooth, https://oeis.org/A080197
        # 17-smooth, https://oeis.org/A080681
        # 19-smooth, https://oeis.org/A080682
        # TODO
        # 23-smooth, https://oeis.org/A080683
        @test smooth(23, 72) ⩦ [
        1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
        20,21,22,23,24,25,26,27,28,30,32,33,34,35,36,38,
        39,40,42,44,45,46,48,49,50,51,52,54,55,56,57,60,
        63,64,65,66,68,69,70,72,75,76,77,78,80,81,84,85,
        88,90,91,92,95]
        # 2^i * 5^j, https://oeis.org/A003592
        @test with_bases([2, 5], 48) ⩦ [
            1,2,4,5,8,10,16,20,25,32,40,50,64,80,100,125,128,
            160,200,250,256,320,400,500,512,625,640,800,1000,
            1024,1250,1280,1600,2000,2048,2500,2560,3125,3200,
            4000,4096,5000,5120,6250,6400,8000,8192,10000]
        # 3^i * 5^j, https://oeis.org/A003593
        @test with_bases([3, 5], 44) ⩦ [
            1,3,5,9,15,25,27,45,75,81,125,135,225,243,375,
            405,625,675,729,1125,1215,1875,2025,2187,3125,
            3375,3645,5625,6075,6561,9375,10125,10935,15625,
            16875,18225,19683,28125,30375,32805,46875,50625,
            54675,59049]
        # 2^i * 7^j, https://oeis.org/A003591
        # 3^i * 7^j, https://oeis.org/A003594
        # 5^i * 7^j, https://oeis.org/A003595
        # TODO
        # 3^i * 4^j, https://oeis.org/A025613
        @test with_bases([3, 4], 47) ⩦ [
            1,3,4,9,12,16,27,36,48,64,81,108,144,192,243,256,
            324,432,576,729,768,972,1024,1296,1728,2187,2304,
            2916,3072,3888,4096,5184,6561,6912,8748,9216,
            11664,12288,15552,16384,19683,20736,26244,27648,
            34992,36864,46656]
    end
end
