!! Albina Oscherowa (4694823)
!! Karsten Lehmann (4935758)
PROGRAM RoundingError
  !! Das tatsächliche Ergebnis des Ausdruck x^4 − 4y^4 − 4y^2 für x = 665857 und
  !! y = 470832 lautet 1. In der folgenden Tabelle sind die Ergebnisse für die
  !! angegeben Precision P und Exponent Range R der Datentypen von x und y
  !! dargestellt.
  !! Ausdruck                                       | P=6, R=37         | P=15, R=307 | P=18, R=4931
  !! -----------------------------------------------|-------------------|-------------|-------------
  !! x**4 - 4*y**4 - 4*y**2                         | −8.86731112E + 11 |    11885568 |        7168
  !! x*x*x*x - 4*y*y*y*y - 4*y*y                    | −8.86731112E + 11 |    11885568 |        7168
  !! (x**2)**2 - (2*y**2)**2 - (2*y)**2             | −8.86731112E + 11 |    11885568 |        7168
  !! (x**2)**2 - (2*y)**2*(y**2 + 1)                |                 0 |           0 |           0
  !! (x*x - 2*y*(y+1)) * (x*x + 2*y*(y+1)) + 8*y**3 |  2.14225410E + 16 |           0 |           1
  !! (x**2 - 2*y**2) * (x**2 + 2*y**2) - 4*y**2     | −8.86731112E + 11 |           1 |           1
  !!
  !! Wie zu erkennen, sind die korrekten Ergebnisse nur in der unteren rechten Ecke
  !! der Tabelle enthalten. Warum ist das so?
  !! Die Variablen x und y, sowie die Ergebnisse der Berechnungen werden als
  !! Gleitkommazahlen gespeichert.
  !!
  !! Gleitkommazahlen beinhalten Zahlen mit Stellen vor und nach dem Komma.
  !! Da bei Kommazahlen festgelegte Stellen für die Vor- und Nachkommastellen
  !! eher hinderlich wären, hat man bei der Gleitkommadarstellung dafür gesorgt,
  !! dass das Komma jede beliebige Stelle einnehmen kann. Man spricht davon, dass
  !! das Komma ”gleitet”
  !! https://www.elektronik-kompendium.de/sites/dig/1807231.htm 
  !!
  !! Diesen Gleitkommazahlen sind in der Genauigkeit Grenzen gesetzt. Dadurch
  !! kommt es zu Rundungsfehlern und Auslöschungen. Insgesamt kann man se-
  !! hen, dass sich die Lösungen mit gesteigerter Genauigkeit den korrekten Werten
  !! annähern. Weiterhin hängt die Qualität des Ergebnisses auch von den Zwis-
  !! chenschritten der Berechnung ab. Je geringer der Betrag der Ergebnisse der
  !! einzelnen Zwischenschritte der Rechnung ist, desto genauer ist das Ergebnis.
  IMPLICIT NONE
  !! Choose REAL type with decimal precision >=P and decimal range >=R :
  INTEGER, PARAMETER :: real_kind= SELECTED_REAL_KIND(P=6, R=37)
  !INTEGER, PARAMETER :: real_kind= SELECTED_REAL_KIND(P=15, R=307)
  !INTEGER, PARAMETER :: real_kind= SELECTED_REAL_KIND(P=18, R=4931)
  REAL(KIND=real_kind) :: x, y, z
  WRITE(*,*) ' Please enter integer or real values for x and y: '
  READ (*,*) x, y
  WRITE(*,*) ' x**4 = ', x ** 4
  z= x**4 - 4*y**4 - 4*y**2
  WRITE(*,*) ' x**4 - 4*y**4 - 4*y**2 = ', z
  z= x*x*x*x - 4*y*y*y*y - 4*y*y
  WRITE(*,*) ' x*x*x*x - 4*y*y*y*y - 4*y*y = ', z
  z= (x**2)**2 - (2*y**2)**2 - (2*y)**2
  WRITE(*,*) ' (x**2)**2 - (2*y**2)**2 - (2*y)**2 = ', z
  z= (x**2)**2 - (2*y)**2*(y**2 + 1) 
  WRITE(*,*) ' (x**2)**2 - (2*y)**2*(y**2 + 1) = ', z
  z= (x*x - 2*y*(y+1)) * (x*x + 2*y*(y+1)) + 8*y**3
  WRITE (*,*) ' (x*x-2*y*(y+1)) * (x*x+2*y*(y+1)) + 8*y**3 = ', z
  z= (x**2 - 2*y**2) * (x**2 + 2*y**2) - 4*y**2
  WRITE (*,*) ' (x**2-2*y**2) * (x**2+2*y**2) - 4*y**2 = ', z
END PROGRAM RoundingError
