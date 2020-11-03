#! /usr/bin/env bats

@test "namen.f95" {
      run ./namen <<EOF
Mara
Muster
EOF
      [[ "$status" -eq 0 ]]
      [[ "$output" == *"Hallo Mara Muster!"* ]]
      [[ "$output" == *"Mara ist ein schoener Name. :)"* ]]
}


@test "taschenrechner.f95" {
      run ./taschenrechner <<EOF
27
15
EOF
	echo -e $output > test.out
      [[ "$status" -eq 0 ]]
      [[ "$output" =~ a[[:space:]]\+[[:space:]]b[[:space:]]=[[:space:]]*42 ]]
}