// A minimal MLIR program that is already in the LLVM dialect.

module {
  llvm.func @puts(!llvm.ptr) -> i32
  llvm.func @printf(!llvm.ptr, ...) -> i32

  llvm.mlir.global internal constant @hello_world("Hello, world!\00") : 
    !llvm.array<14 x i8>

  llvm.mlir.global internal constant @hello_again("Hello, again!\0A\00") : 
    !llvm.array<15 x i8>

  llvm.func @main() -> i32 {
    %message = llvm.mlir.addressof @hello_world : !llvm.ptr
    %unused = llvm.call @puts(%message) : (!llvm.ptr) -> i32
    %message2 = llvm.mlir.addressof @hello_again : !llvm.ptr
    %unused2 = llvm.call @printf(%message2) vararg(!llvm.func<i32 (ptr, ...)>) : 
        (!llvm.ptr) -> i32
    %zero = llvm.mlir.constant(0 : i32) : i32
    llvm.return %zero : i32
  }
}
