module {
  llvm.func @printf(!llvm.ptr, ...) -> i32

  llvm.mlir.global internal constant @input_fmt
    ("input=[\0A  [%.2f, %.2f, %.2f]\0A  [%.2f, %.2f, %.2f]\0A]\0A\00") : 
    !llvm.array<53 x i8>

  llvm.mlir.global internal constant @output_fmt
    ("output=[\0A  [%.2f, %.2f]\0A  [%.2f, %.2f]\0A  [%.2f, %.2f]\0A]\0A\00") : 
    !llvm.array<57 x i8>

  func.func @print_input_vector(%v: vector<2x3xf32>) {
    %f0 = vector.extract %v[0, 0] : f32 from vector<2x3xf32>
    %f1 = vector.extract %v[0, 1] : f32 from vector<2x3xf32>
    %f2 = vector.extract %v[0, 2] : f32 from vector<2x3xf32>
    %f3 = vector.extract %v[1, 0] : f32 from vector<2x3xf32>
    %f4 = vector.extract %v[1, 1] : f32 from vector<2x3xf32>
    %f5 = vector.extract %v[1, 2] : f32 from vector<2x3xf32>

    %fmt = llvm.mlir.addressof @input_fmt : !llvm.ptr
    llvm.call @printf(%fmt, %f0, %f1, %f2, %f3, %f4, %f5) 
      vararg(!llvm.func<i32 (ptr, ...)>) 
      : (!llvm.ptr, f32, f32, f32, f32, f32, f32) -> i32
    func.return
  }

  func.func @print_output_vector(%v: vector<3x2xf32>) {
    %f0 = vector.extract %v[0, 0] : f32 from vector<3x2xf32>
    %f1 = vector.extract %v[0, 1] : f32 from vector<3x2xf32>
    %f2 = vector.extract %v[1, 0] : f32 from vector<3x2xf32>
    %f3 = vector.extract %v[1, 1] : f32 from vector<3x2xf32>
    %f4 = vector.extract %v[2, 0] : f32 from vector<3x2xf32>
    %f5 = vector.extract %v[2, 1] : f32 from vector<3x2xf32>

    %fmt = llvm.mlir.addressof @output_fmt : !llvm.ptr
    llvm.call @printf(%fmt, %f0, %f1, %f2, %f3, %f4, %f5) 
      vararg(!llvm.func<i32 (ptr, ...)>) 
      : (!llvm.ptr, f32, f32, f32, f32, f32, f32) -> i32
    func.return
  }

  func.func @main() -> i32 {
    %input = arith.constant dense<[
      [1.0, 2.0, 3.0],
      [4.0, 5.0, 6.0]
    ]> : vector<2x3xf32>
    func.call @print_input_vector(%input) : (vector<2x3xf32>) -> ()

    %output = vector.transpose %input, [1, 0] 
      : vector<2x3xf32> to vector<3x2xf32>
    func.call @print_output_vector(%output) : (vector<3x2xf32>) -> ()

    %zero = arith.constant 0 : i32
    llvm.return %zero : i32
  }
}
