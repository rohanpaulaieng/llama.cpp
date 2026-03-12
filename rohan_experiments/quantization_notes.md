# llama.cpp Quantization Notes

Experiments with different quantization levels for Llama-3 70B.

## Quantization Comparison

| Quant | Size | Perplexity | Tokens/sec (RTX 4090) |
|-------|------|-----------|----------------------|
| F16   | 131GB | 5.12 | 8.3 |
| Q8_0  | 70GB  | 5.18 | 14.1 |
| Q6_K  | 54GB  | 5.21 | 18.7 |
| Q5_K_M| 48GB  | 5.29 | 22.4 |
| Q4_K_M| 41GB  | 5.47 | 28.1 |
| Q3_K_M| 31GB  | 5.89 | 35.6 |
| Q2_K  | 25GB  | 7.23 | 44.2 |

## My Recommendation
- **Production**: Q5_K_M — best quality/speed tradeoff
- **Development**: Q4_K_M — faster iteration, acceptable quality
- **Edge/Mobile**: Q3_K_M — if latency is critical

## Build Command
```bash
cmake -B build -DLLAMA_CUDA=ON -DCMAKE_CUDA_ARCHITECTURES=89
cmake --build build --config Release -j$(nproc)
```

## Converting custom models
```bash
python convert_hf_to_gguf.py ./my_finetuned_model --outtype q5_k_m
```