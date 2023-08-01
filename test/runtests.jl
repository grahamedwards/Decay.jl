using Decay
using Test

@testset "Decay.jl" begin

# The basics
    @test Decay.halflife(5) ≈ Decay.lambda(5.) ≈ log(2.)/5.
    
    @test λ.U238 ≈ 1.551254796141587e-10

# Direct decay equations 
    @test Decay.N(Decay.halflife(λ.U238),λ.U238) ≈ 0.5
    
    @test Decay.D(Decay.halflife(λ.U238),λ.U238,N=0.5) ≈ 0.5
    @test Decay.D(Decay.halflife(λ.U238),λ.U238,N=0.5,Do=1) ≈ 1.5

    @test Decay.D_(2*Decay.halflife(λ.U238),λ.U238,No=1) ≈ 0.75
    @test Decay.D_(2*Decay.halflife(λ.U238),λ.U238,No=1,Do=1) ≈ 1.75

# Series decay equations

end
