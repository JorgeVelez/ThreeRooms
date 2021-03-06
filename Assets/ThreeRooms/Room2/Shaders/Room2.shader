Shader "ThreeRooms/Room2"
{
    Properties
    {
        _Columns("Column Count", Int) = 10

        [Space]
        _Color("Color", Color) = (1, 1, 1, 1)

        [Space]
        _Glossiness("Smoothness", Range(0, 1)) = 0.5
        [Gamma] _Metallic("Metallic", Range(0, 1)) = 0

        [Space]
        _LocalTime("Animation Time", Float) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        // This shader only implements the deferred rendering pass (GBuffer
        // construction) and the shadow caster pass, so that it doesn't
        // support forward rendering.

        Pass
        {
            Tags { "LightMode"="Deferred" }
            CGPROGRAM
            #pragma target 4.0
            #pragma vertex Vertex
            #pragma geometry Geometry
            #pragma fragment Fragment
            #pragma multi_compile_prepassfinal noshadowmask nodynlightmap nodirlightmap nolightmap
            #include "Room2.hlsl"
            ENDCG
        }

        Pass
        {
            Tags { "LightMode"="ShadowCaster" }
            CGPROGRAM
            #pragma target 4.0
            #pragma vertex Vertex
            #pragma geometry Geometry
            #pragma fragment Fragment
            #pragma multi_compile_shadowcaster noshadowmask nodynlightmap nodirlightmap nolightmap
            #ifndef UNITY_PASS_SHADOWCASTER
            #define UNITY_PASS_SHADOWCASTER
            #endif
            #include "Room2.hlsl"
            ENDCG
        }
    }
}
