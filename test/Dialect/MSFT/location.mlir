// RUN: circt-opt %s -verify-diagnostics | circt-opt -verify-diagnostics | FileCheck %s
// RUN: circt-translate %s --export-quartus-tcl | FileCheck %s --check-prefix=TCL

hw.module.extern @Foo()

// TCL-LABEL: proc top_config
hw.module @top() {
  // CHECK: hw.instance "foo1" @Foo() {"loc:memBank1" = #msft.physloc<M20K, 4, 10, 1>}
  // TCL:   set_location_assignment M20K_X4_Y10_N1 -to $parent|foo1|memBank1
  hw.instance "foo1" @Foo() {"loc:memBank1" = #msft.physloc<M20K, 4, 10, 1> } : () -> ()

  // CHECK: hw.instance "foo2" @Foo() {"loc:memBank2" = #msft.physloc<M20K, 5, 10, 1>}
  // TCL:   set_location_assignment M20K_X5_Y10_N1 -to $parent|foo2|memBank2
  hw.instance "foo2" @Foo() {"loc:memBank2" = #msft.physloc<M20K, 5, 10, 1> } : () -> ()
}


hw.module @leaf() {
  // CHECK: hw.instance "foo3" @Foo() {"loc:memBank2" = #msft.switch.inst<@fakeTop=#msft.physloc<M20K, 8, 19, 1>, @realTop::@fakeTop=#msft.physloc<M20K, 15, 9, 3>>}
  hw.instance "foo3" @Foo() {
    "loc:memBank2" = #msft.switch.inst< @fakeTop=#msft.physloc<M20K, 8, 19, 1>,
                                        @realTop::@fakeTop=#msft.physloc<M20K, 15, 9, 3> > } : () -> ()
}

// TCL-LABEL: proc realTop_config
hw.module @realTop() {
  hw.instance "fakeTop" @leaf() : () -> ()
  // TCL: set_location_assignment M20K_X8_Y19_N1 -to $parent|fakeTop|foo3|memBank2
}

// TCL-LABEL: proc forRealsiesTop_config
hw.module @forRealsiesTop() {
  hw.instance "realTop" @realTop() : () -> ()
  hw.instance "fakeTop" @leaf() : () -> ()
  // TCL: set_location_assignment M20K_X15_Y9_N3 -to $parent|realTop|fakeTop|foo3|memBank2
  // TCL: set_location_assignment M20K_X8_Y19_N1 -to $parent|fakeTop|foo3|memBank2
}
