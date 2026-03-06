module common;

[require(spirv, subgroup_basic)]
public uint WaveGetWaveIndex() {
    __target_switch
    {
    case spirv:
        return spirv_asm {
                    OpCapability GroupNonUniform;
                    result:$$uint = OpLoad builtin(SubgroupId:uint);
                };
    }
}

public interface IReduceOp<T> {
    static T combine(T a, T b);
}

public struct MaxOp<T: IArithmetic> : IReduceOp<T> {
    static T combine(T a, T b) { return max(a, b); }
}
public struct AddOp<T: IArithmetic> : IReduceOp<T> {
    static T combine(T a, T b) { return a + b; }
}
