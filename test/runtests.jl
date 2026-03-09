using Decay
using Test

@testset "Decay.jl" begin

    l = Decay.lambda

# The basics
    @test Decay.halflife(5) ≈ Decay.decayconstant(5.) ≈ log(2.)/5.
    
    @test l.U238 ≈ 1.551254796141587e-10

# Direct decay equations 
    @test Decay.N(Decay.halflife(l.U238),l.U238) ≈ 0.5
    
    @test Decay.D(Decay.halflife(l.U238),l.U238,N=0.5) ≈ 0.5
    @test Decay.D(Decay.halflife(l.U238),l.U238,N=0.5,Do=1) ≈ 1.5

    @test Decay.D_(2*Decay.halflife(l.U238),l.U238,No=1) ≈ 0.75
    @test Decay.D_(2*Decay.halflife(l.U238),l.U238,No=1,Do=1) ≈ 1.75

# Series decay equations
    @test Decay.dN2_dt(l.U234,l.U238,N1=1,N2=0) ≈ 1.551254796141587e-10
    @test Decay.N2(1e6,l.U234,l.U238,N1o=1,N2o=0) ≈ Decay.Q(1e6,l.U234,l.U238,P0=1,Q0=0) ≈ 5.169390742865588e-5
    @test Decay.R(5e5, l.Th230, l.U234, l.U238, R0=0, Q0=l.U238/l.U234, P0=1) ≈ 1.6742628389341084e-5


# Activity Calculations

    @test Becquerel(Curie(1)).n ≈ 3.7e10
    @test Becquerel(DPM(60)).n ≈ 1
    @test Becquerel(PerYear(31557600)).n ≈ 1
    
    @test Curie(Becquerel(3.7e10)).n ≈ 1
    @test Curie(DPM(3.7e10*60)).n ≈ 1
    @test Curie(PerYear(31557600*3.7e10)).n ≈ 1

    @test DPM(Curie(1)).n ≈ 2.22e12
    @test DPM(Becquerel(1)).n ≈ 60
    @test DPM(PerYear(31557600)).n ≈ 60

    @test Ci(1) == Curie(1)
    @test Ci(Becquerel(1)) == Curie(Becquerel(1))

    @test Bq(1) == Becquerel(1)
    @test Bq(Curie(1)) == Becquerel(Curie(1))
    
end
