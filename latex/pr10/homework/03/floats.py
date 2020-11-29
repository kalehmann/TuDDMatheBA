#! /usr/bin/env python3

from fractions import Fraction

def float2D(exponents, mantissa_bits):
    base = 2 ** mantissa_bits

    return [
        [
            Fraction(m, int(base / (2 ** e))) for m in range(base)
        ]
        for e in exponents
    ]

def isNormalized(f: Fraction, mantissa_bits: int, exponents) -> bool:
    denominators = [(2 ** mantissa_bits) / (2 ** e) for e in exponents]
    m = f.numerator

    for d in sorted(denominators, reverse=True):
        if d < f.denominator:
            # Cannot represent mantissa
            return
        if len("{:b}".format(int(m * d / f.denominator))) == mantissa_bits:
            return True
    return False

def main():
    mantissa_bits =5
    exps = (-1 , 0, 1, 2)
    f = float2D(exps, mantissa_bits)

    print(f"      \\begin{{array}}{{c | {'M' * 2**mantissa_bits}}}")
    print("        m_x * 2^{e_x} & \\rot{0." + "} & \\rot{0.".join(map(f"{{:0{mantissa_bits}b}}".format, range(2**mantissa_bits))) + "} \\\\")
    print("        \\hline")
    for e, line in zip(exps, f):
        print(f"        e_x = {e} & " + " & ".join(map(lambda x: str(x) if int(x) == x else f"\\sfrac{{{ x.numerator }}}{{{ x.denominator }}}", line)) +  " \\\\")
    print("      \\end{array}")

    s = sorted(set(sum(f, [])))
    print("  \\begin{tikzpicture}")
    print("    \\coordinate (c0) at (0,0);")
    print("    \\coordinate (c1) at (22,0);")
    print("    \\draw[-latex] (c0) -> (c1);")
    for i in s:
        if not isNormalized(i, mantissa_bits, exps):
            # Gotta leading zeros, so not normalized
            print(f"    \\draw[red,shift={{({ 20 / max(s) * float(i) },0)}}] (0pt,5pt) -- (0pt,0pt);")
        else:
            print(f"    \\draw[shift={{({ 20 / max(s) * float(i) },0)}}] (0pt,5pt) -- (0pt,0pt);")
        if int(i) == i:
            print(f"    \\draw[shift={{({ 20 / max(s) * float(i) },0)}}] (0pt,7pt) -- (0pt,-12pt) node[below] {{{str(i)}}};")
        if i % 1 == .5:
            print(f"    \\draw[shift={{({ 20 / max(s) * float(i) },0)}}] (0pt,7pt) -- (0pt,-8pt) node[below] {{{float(i)}}};")
        elif i % .5 == .25:
            print(f"    \\draw[shift={{({ 20 / max(s) * float(i) },0)}}] (0pt,7pt) -- (0pt,-5pt) node[below] {{{float(i)}}};")

    print("  \\end{tikzpicture}")

    print(max(s))
if __name__ == "__main__":
    main()
