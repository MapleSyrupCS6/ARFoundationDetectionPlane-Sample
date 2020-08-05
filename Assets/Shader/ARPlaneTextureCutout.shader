Shader "Custom/ARPlaneTextureCutout"
{
    Properties
    {
        _MainTex("MainTex", 2D) = "white"{}
        _Color("_Color", Color) = (1, 1, 1, 1)
        _CutOff("CutOff", Range(0, 1)) = 0.5
        _Ratio("Ratio", float) = 1
    }
    SubShader
    {
        Blend SrcAlpha OneMinusSrcAlpha
        Pass{
        Tags {"Queue" = "AlphaTest" "RenderType"="TransparentCutout" }
        LOD 200

        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag
        #include "UnityCG.cginc"

        struct appdata
        {
            float4 vertex : POSITION;
            float2 uv : TEXCOORD0;
        };

        struct v2f
        {
            float4 position : SV_POSITION;
            float2 uv : TEXCOORD0;
        };

        v2f vert(appdata input)
        {
            v2f output;
            output.position = UnityObjectToClipPos(input.vertex);
            output.uv = input.uv;
            return output;
        }

        sampler2D _MainTex;
        float4 _MainTex_ST;
        fixed _CutOff;
        fixed4 _Color;
        float _Ratio;

        fixed4 frag (v2f input) :  SV_Target
        {
            float2 uv = input.uv * _Ratio;
            float2 st = frac(uv);
            fixed4 col = tex2D(_MainTex, st);
            clip(col.a - _CutOff);
            col *= _Color;
            
            return col;
        }
        ENDCG
        }
    }
}
