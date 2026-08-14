# MLIR tests

## Lowering
```
mlir-opt --convert-vector-to-llvm --convert-ub-to-llvm --convert-func-to-llvm --convert-arith-to-llvm --reconcile-unrealized-casts vector-transpose.mlir -o vector-transpose-lowered.mlir
```

## Running
```
mlir-translate --mlir-to-llvmir hello-world.mlir -o hello-world.ll
lli hello-world.ll
```
