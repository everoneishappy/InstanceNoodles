#include "..\..\..\Common\InstanceNoodles.fxh"

StructuredBuffer<float3> inputBuffer;
float3 inputDefualt = 0;

StructuredBuffer<float4x4> transformBuffer;
float4x4 transformDefault;

bool wComponent = 1;

RWStructuredBuffer<float3> RWValueBuffer : BACKBUFFER;


[numthreads(64,1,1)]
void CS_Multiply(uint3 dtid : SV_DispatchThreadID)
{
	if (dtid.x >= threadCount) { return; }

	float4 value = float4(bLoad(inputBuffer, inputDefualt, dtid.x), wComponent);
	float4x4 transform = bLoad(transformBuffer, transformDefault, dtid.x);
	
	float3 result = mul(value, transform).xyz;

	
	RWValueBuffer[dtid.x] = result;	
}



technique11 Multiply
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_Multiply() ) );
	}
}

