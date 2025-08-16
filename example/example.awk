1
0x02
"three"
04
0.5e1
60e-1
/needle/
match($3, "needle")

[1, 0x02, "three", 04, 0.5e1, 60e-1, /needle/, match($3, "needle")]

[1, 0x02, ["three", 04, 0.5e1], 60e-1, [/needle/], match($3, "needle")]

[
    1, 0x02, "three", 04, 0.5e1, 60e-1, /needle/, match($3, "needle")
]

foo[1]["two"][0x03] = 0.4e1
