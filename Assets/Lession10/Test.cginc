#ifndef TestTriColor
#define TestTriColor
// 3Col环境色方法
float3 TriColAnimibent(float3 nDirWS, float3 upColor, float3 middleColor, float3 downColor)
{
    float upMask = max(0, nDirWS.g);
    float downMask = max(0, -nDirWS.g);
    float middleMask = 1 - upMask - downMask;
    float3 envColor = upColor * upMask + downColor * downMask + middleColor * middleMask;
    return envColor;
}
#endif
