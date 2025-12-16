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
    @test Decay.dN2_dt(λ.U234,λ.U238,N1=1,N2=0) ≈ 1.551254796141587e-10
    @test Decay.N2(1e6,λ.U234,λ.U238,N1o=1,N2o=0) ≈ Decay.Q(1e6,λ.U234,λ.U238,P0=1,Q0=0) ≈ 5.169390742865588e-5
    @test Decay.R(5e5, λ.Th230, λ.U234, λ.U238, R0=0, Q0=λ.U238/λ.U234, P0=1) ≈ 1.6742628389341084e-5
    
end
