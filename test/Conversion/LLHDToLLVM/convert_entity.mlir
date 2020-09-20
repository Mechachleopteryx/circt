// NOTE: Assertions have been autogenerated by utils/generate-test-checks.py
//RUN: circt-opt %s --convert-llhd-to-llvm --split-input-file | FileCheck %s

// CHECK-LABEL:   llvm.func @convert_empty(
// CHECK-SAME:                             %[[VAL_0:.*]]: !llvm.ptr<i8>,
// CHECK-SAME:                             %[[VAL_1:.*]]: !llvm.ptr<struct<(ptr<i8>, i64, i64, i64)>>) {
// CHECK:           llvm.return
// CHECK:         }
llhd.entity @convert_empty () -> () {}

// CHECK-LABEL:   llvm.func @convert_one_input(
// CHECK-SAME:                                 %[[VAL_0:.*]]: !llvm.ptr<i8>,
// CHECK-SAME:                                 %[[VAL_1:.*]]: !llvm.ptr<struct<(ptr<i8>, i64, i64, i64)>>) {
// CHECK:           %[[VAL_2:.*]] = llvm.mlir.constant(0 : i32) : !llvm.i32
// CHECK:           %[[VAL_3:.*]] = llvm.getelementptr %[[VAL_1]]{{\[}}%[[VAL_2]]] : (!llvm.ptr<struct<(ptr<i8>, i64, i64, i64)>>, !llvm.i32) -> !llvm.ptr<struct<(ptr<i8>, i64, i64, i64)>>
// CHECK:           llvm.return
// CHECK:         }
llhd.entity @convert_one_input (%in0 : !llhd.sig<i1>) -> () {}

// CHECK-LABEL:   llvm.func @convert_one_output(
// CHECK-SAME:                                  %[[VAL_0:.*]]: !llvm.ptr<i8>,
// CHECK-SAME:                                  %[[VAL_1:.*]]: !llvm.ptr<struct<(ptr<i8>, i64, i64, i64)>>) {
// CHECK:           %[[VAL_2:.*]] = llvm.mlir.constant(0 : i32) : !llvm.i32
// CHECK:           %[[VAL_3:.*]] = llvm.getelementptr %[[VAL_1]]{{\[}}%[[VAL_2]]] : (!llvm.ptr<struct<(ptr<i8>, i64, i64, i64)>>, !llvm.i32) -> !llvm.ptr<struct<(ptr<i8>, i64, i64, i64)>>
// CHECK:           llvm.return
// CHECK:         }
llhd.entity @convert_one_output () -> (%out0 : !llhd.sig<i1>) {}

// CHECK-LABEL:   llvm.func @convert_input_and_output(
// CHECK-SAME:                                        %[[VAL_0:.*]]: !llvm.ptr<i8>,
// CHECK-SAME:                                        %[[VAL_1:.*]]: !llvm.ptr<struct<(ptr<i8>, i64, i64, i64)>>) {
// CHECK:           %[[VAL_2:.*]] = llvm.mlir.constant(0 : i32) : !llvm.i32
// CHECK:           %[[VAL_3:.*]] = llvm.getelementptr %[[VAL_1]]{{\[}}%[[VAL_2]]] : (!llvm.ptr<struct<(ptr<i8>, i64, i64, i64)>>, !llvm.i32) -> !llvm.ptr<struct<(ptr<i8>, i64, i64, i64)>>
// CHECK:           %[[VAL_4:.*]] = llvm.mlir.constant(1 : i32) : !llvm.i32
// CHECK:           %[[VAL_5:.*]] = llvm.getelementptr %[[VAL_1]]{{\[}}%[[VAL_4]]] : (!llvm.ptr<struct<(ptr<i8>, i64, i64, i64)>>, !llvm.i32) -> !llvm.ptr<struct<(ptr<i8>, i64, i64, i64)>>
// CHECK:           llvm.return
// CHECK:         }
llhd.entity @convert_input_and_output (%in0 : !llhd.sig<i1>) -> (%out0 : !llhd.sig<i1>) {}