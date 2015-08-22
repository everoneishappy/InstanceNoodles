#include "..\..\..\Common\InstanceNoodles.fxh"

RWStructuredBuffer<float2> output : BACKBUFFER;

float lerpValue = 0;
StructuredBuffer<float> lerpBuffer;

float2 dv1, dv2 = 0;
StructuredBuffer<float2> bv1, bv2;





[numthreads(64, 1, 1)]
void CSlerp( uint3 dtid : SV_DispatchThreadID)
{ 
	if (dtid.x >= threadCount) { return; }
	
	float2 v1 = bLoad(bv1, dv1, dtid.x);
	float2 v2 = bLoad(bv2, dv2, dtid.x);
	float l = bLoad(lerpBuffer, lerpValue, dtid.x);

	output[dtid.x] = lerp(v1, v2, l);
}



technique11 Lerp
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CSlerp() ) );
	}
}







