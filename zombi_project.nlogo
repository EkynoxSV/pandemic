__includes [ "humains.nls" "zombies.nls" "objets.nls" ]

;Modèle de propagation d'épidemie zombie



directed-link-breed [contaminations contamination]


patches-own[
  accessible?
  arme_in?
  barricade_in?
]



to init-patches
  import-pcolors "carte.png"
  ask patches [
    set arme_in? false
    ifelse (pcolor = black) [
      set accessible? true
    ]
    [set accessible? false]
  ]
  ask one-of patches with [accessible?] [
    set pcolor blue
    ask patches in-radius 1 with [accessible?][
      set pcolor blue
    ]
  ]
end

to init-simulation
  __clear-all-and-reset-ticks
  init-patches
  init-humains
  init-objet

  initialisation-epidemie
end

; commun aux humains et aux zombies
to deplacement-aleatoire
  let patches_possibles (patches with [accessible?] in-radius dist_max_deplacement)
  if any? patches_possibles[
    move-to one-of patches_possibles
  ]
end


to deplacements-individus
 ask (zombies)[
  deplacement-zombies
 ]
  ask (humains)
  [
      deplacement-humains
  ]
end




to initialisation-epidemie
  ask n-of (taux_infectes_init * count humains) humains
    [
      devient-infecte
    ]
end





to pas-simulation
    if count humains = 0
    [ stop ]
  if count zombies = 0
    [ stop ]
  deplacements-individus
  tick
end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
647
448
-1
-1
13.0
1
10
1
1
1
0
0
0
1
-16
16
-16
16
0
0
1
ticks
30.0

SLIDER
22
43
194
76
nb_individus
nb_individus
0
100
50.0
1
1
NIL
HORIZONTAL

BUTTON
6
519
77
552
Init
init-simulation
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
22
93
194
126
dist_max_deplacement
dist_max_deplacement
0
5
2.0
1
1
NIL
HORIZONTAL

BUTTON
90
518
161
551
Launch
pas-simulation
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
1269
14
1441
47
taux_infectes_init
taux_infectes_init
0
1
0.1
0.1
1
NIL
HORIZONTAL

SLIDER
1268
67
1440
100
dist_infection
dist_infection
0
5
1.0
1
1
NIL
HORIZONTAL

SLIDER
1269
109
1441
142
proba_touche
proba_touche
0
1
0.1
0.1
1
NIL
HORIZONTAL

MONITOR
695
38
788
83
taux_infecté
count zombies / (count zombies + count humains)
17
1
11

PLOT
689
100
1231
454
Évolution de l'épidémie
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"humains" 1.0 0 -11085214 true "" "plot count humains"
"zombies" 1.0 0 -2674135 true "" "plot count zombies"

SLIDER
20
140
192
173
dist_perception
dist_perception
0
10
4.0
1
1
NIL
HORIZONTAL

SLIDER
23
194
195
227
nb_armes
nb_armes
0
20
10.0
1
1
NIL
HORIZONTAL

SLIDER
21
248
193
281
puissance_arme
puissance_arme
0
1
0.2
0.1
1
NIL
HORIZONTAL

SLIDER
1274
158
1446
191
proba_infection
proba_infection
0
1
0.75
0.05
1
NIL
HORIZONTAL

SLIDER
1274
219
1449
252
multi_vitesse_sprinter
multi_vitesse_sprinter
1
4
2.5
0.25
1
NIL
HORIZONTAL

SLIDER
1274
277
1490
310
multi_resistance_mastodonte
multi_resistance_mastodonte
1
4
2.5
0.25
1
NIL
HORIZONTAL

SLIDER
1275
332
1540
365
multi_distance_contamination_virulent
multi_distance_contamination_virulent
1
4
1.75
0.25
1
NIL
HORIZONTAL

SLIDER
388
477
421
627
chance_standard
chance_standard
0
1
0.3
0.1
1
NIL
VERTICAL

SLIDER
468
477
501
627
chance_mastodonte
chance_mastodonte
0
1
0.1
0.1
1
NIL
VERTICAL

SLIDER
549
477
582
627
chance_virulent
chance_virulent
0
1
0.1
0.1
1
NIL
VERTICAL

SLIDER
509
477
542
627
chance_rampant
chance_rampant
0
1
0.2
0.1
1
NIL
VERTICAL

SLIDER
428
477
461
627
chance_sprinteur
chance_sprinteur
0
1
0.3
0.1
1
NIL
VERTICAL

SLIDER
21
307
193
340
nb_barricades
nb_barricades
0
20
10.0
1
1
NIL
HORIZONTAL

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

barricade
false
0
Rectangle -7500403 false true 0 75 300 225
Rectangle -7500403 true true 0 75 300 225
Line -16777216 false 0 210 300 210
Line -16777216 false 0 90 300 90
Line -16777216 false 150 90 150 210
Line -16777216 false 120 90 120 210
Line -16777216 false 90 90 90 210
Line -16777216 false 240 90 240 210
Line -16777216 false 270 90 270 210
Line -16777216 false 30 90 30 210
Line -16777216 false 60 90 60 210
Line -16777216 false 210 90 210 210
Line -16777216 false 180 90 180 210
Polygon -7500403 true true 1 77 8 64 12 76 22 63 26 75 40 63 44 75 61 63 67 75 70 63 78 74 80 63 92 73 97 65 99 76 109 70 111 75
Polygon -7500403 true true 121 77 132 66 137 77 141 68 136 61 132 60 135 55 140 55 141 60 147 63 147 69 159 53 156 64 154 71 159 76 164 65 168 75 168 63 181 78 184 66 191 76 193 67 199 74 203 68 191 60 210 60 211 77 225 64 224 75 236 76 231 69 239 64 243 77 250 63 251 75 258 63 262 78 268 62 276 74 277 64 291 70 293 76 124 77 130 72
Polygon -2674135 true false 139 63 133 59 132 60 133 55 137 55 140 55 141 55 140 59 140 62
Polygon -2674135 true false 194 59 205 60 200 65 192 59 196 59
Polygon -2674135 true false 240 63 233 68 236 71 240 69 239 63
Polygon -2674135 true false 63 72 55 70 58 66
Polygon -2674135 true false 79 62 79 70 83 72 87 70 84 66 80 63
Polygon -2674135 true false 268 63 264 71 267 71 270 72 273 69 271 66 268 64
Polygon -2674135 true false 158 54 151 62 154 67 156 67 159 53
Polygon -2674135 true false 55 106 52 113 56 120 55 124 57 128 59 135 62 129 58 124 58 116 55 106
Polygon -16777216 true false 181 128 172 137 172 151 167 159 165 174 159 187 157 194 162 201 167 195 164 191 169 181 170 169 175 167 182 166 179 153 174 154 180 128
Polygon -2674135 true false 163 199 160 204 157 208 160 203 158 201 163 199 165 201
Polygon -2674135 true false 161 204 161 214 165 217 166 210 164 199 162 202
Polygon -2674135 true false 183 165 182 169 186 173
Polygon -2674135 true false 176 167 173 172 177 181 182 178 176 169

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

container
false
0
Rectangle -7500403 false false 0 75 300 225
Rectangle -7500403 true true 0 75 300 225
Line -16777216 false 0 210 300 210
Line -16777216 false 0 90 300 90
Line -16777216 false 150 90 150 210
Line -16777216 false 120 90 120 210
Line -16777216 false 90 90 90 210
Line -16777216 false 240 90 240 210
Line -16777216 false 270 90 270 210
Line -16777216 false 30 90 30 210
Line -16777216 false 60 90 60 210
Line -16777216 false 210 90 210 210
Line -16777216 false 180 90 180 210

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

lance
false
0
Polygon -1 true false 87 191 103 218 238 53 223 38
Polygon -13345367 true false 104 204 104 218 239 53 235 47
Polygon -7500403 true true 99 173 83 175 71 186 64 207 52 235 45 251 77 238 108 227 124 205 118 185
Polygon -2674135 true false 62 213 44 252 67 239 69 232 64 231 66 226 64 223 66 220 61 214

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

mastodonte
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 43 59 93 194 88 284 103 299 133 299 148 224 163 299 193 299 208 284 197 195 253 59
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 255 60 279 179 237 163 210 75
Polygon -7500403 true true 45 60 15 165 60 150 90 60
Line -10899396 false 180 30 180 30
Rectangle -16777216 true false 161 23 177 43
Rectangle -10899396 true false 135 30 135 45
Rectangle -16777216 true false 127 28 147 48
Polygon -2674135 true false 129 69 124 55 133 70 136 56 140 68 146 55 147 71 153 59 158 71 164 59 167 72 177 60 130 54
Rectangle -16777216 true false 135 38 142 46
Rectangle -16777216 true false 165 33 172 42
Polygon -7500403 true true 93 119
Polygon -2674135 true false 94 117 92 127 96 126 95 135 98 133 101 142 103 150 100 145 107 148 106 143 106 139 103 134 99 131 102 140 101 128 101 121 99 122 95 120
Polygon -2674135 true false 170 144 167 154 170 162 165 168 165 179 166 185 166 191 160 196 160 193 158 192 163 184 167 179 166 168 161 168 159 163 154 165 154 160 160 156 161 155 167 159 170 154 178 150 180 143 173 143 173 138 169 147
Polygon -2674135 true false 130 110 128 120 134 122 134 126 131 126 128 131 128 124 129 120 126 145 131 151 132 149 134 142
Polygon -2674135 true false 164 99 155 104 163 108 165 108 173 99 174 109 167 113 164 117 159 114 151 117 158 107 165 101 163 100 161 102
Polygon -2674135 true false 122 112 115 119 109 117 114 110 114 106 111 105 111 99 112 96
Polygon -2674135 true false 136 295 133 291 129 291 126 296 133 299 135 298 117 299
Polygon -2674135 true false 122 291 104 284 94 274
Polygon -2674135 true false 103 289 111 297 115 291 106 290 101 289 106 296 112 295
Polygon -7500403 true true 15 165 60 225 75 210 60 210 60 195 75 195 90 210 90 195 75 180 60 135
Polygon -7500403 true true 237 162 224 196 214 208 211 222 214 240 223 228 231 214 239 229 240 238 239 251 245 254 254 256 260 246 279 175
Polygon -2674135 true false 129 81 129 66 136 79 141 67 148 81 152 70 169 84 171 71 176 86
Polygon -2674135 true false 95 94 83 113 88 130 97 102 98 91 116 90 126 97 129 102 158 105 142 88 136 85 125 90 113 85 113 85 96 95 88 110 89 117 104 128 115 142 114 158 120 186 120 202 117 226 115 240 121 240
Polygon -6459832 true false 26 112 30 81 37 65 46 58 57 53 67 48 82 48 96 55 108 56
Polygon -6459832 true false 189 57 209 50 223 50 235 49 246 49 259 54 266 61 268 73 269 78 268 82 271 82 270 87 268 96

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

rampant
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 102 91 117 196 117 226 132 241 147 256 147 226 168 261 169 228 184 245 177 196 192 91
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 180 98 205 71 227 72 183 133
Polygon -7500403 true true 103 91 61 167 81 175 133 106
Line -10899396 false 180 30 180 30
Rectangle -10899396 true false 161 23 177 43
Rectangle -10899396 true false 135 30 135 45
Rectangle -10899396 true false 127 28 147 48
Polygon -2674135 true false 129 74 129 58 133 75 136 61 140 73 146 60 147 76 153 64 158 76 164 64 167 77 172 64 130 59
Rectangle -16777216 true false 135 38 142 46
Rectangle -16777216 true false 165 33 172 42
Polygon -7500403 true true 93 119
Polygon -2674135 true false 94 117 92 127 96 126 95 135 98 133 101 142 103 150 100 145 107 148 106 143 106 139 103 134 99 131 102 140 101 128 101 121 99 122 95 120
Polygon -2674135 true false 170 144 167 154 170 162 165 168 165 179 166 185 166 191 160 196 160 193 158 192 163 184 167 179 166 168 161 168 159 163 154 165 154 160 160 156 161 155 167 159 170 154 178 150 180 143 173 143 173 138 169 147
Polygon -2674135 true false 130 110 128 120 134 122 134 126 131 126 128 131 128 124 129 120 126 145 131 151 132 149 134 142
Polygon -2674135 true false 166 99 157 104 165 108 167 108 175 99 176 109 169 113 166 117 161 114 153 117 160 107 167 101 165 100 163 102
Polygon -2674135 true false 138 92 131 99 125 97 130 90 130 86 127 85 127 79 128 76
Polygon -2674135 true false 136 295 133 291 129 291 126 296 133 299 135 298 117 299
Polygon -2674135 true false 122 291 104 284 94 274
Polygon -2674135 true false 103 289 111 297 115 291 106 290 101 289 106 296 112 295
Polygon -2674135 true false 118 215 114 261 122 256 124 263 134 258 128 248 122 239 120 218 125 213 126 225 126 239 133 237 128 216 125 207 116 210
Polygon -2674135 true false 140 221 142 252 148 277 154 267 149 246 159 257 154 255 151 260 149 254 149 236 148 227
Polygon -2674135 true false 163 230 171 254 171 276 167 259 165 251 165 243 152 229
Polygon -2674135 true false 177 226 188 253 180 254 178 235

resistant
false
0
Circle -7500403 true true 110 5 80
Polygon -6459832 true false 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105
Circle -7500403 true true 68 179 15
Rectangle -7500403 true true 70 28 82 185
Polygon -7500403 true true 83 30 86 33 89 28 76 4 64 31 68 34 71 30 81 31
Polygon -2674135 true false 76 5 69 20 74 22 76 25 76 28 78 28 81 26 81 25 83 23 79 20 81 12 77 7
Polygon -16777216 true false 145 38 128 30 127 50 140 57 146 36
Polygon -16777216 true false 152 39 169 31 170 51 157 58 151 37

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

sprinteur
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 120 87 143 195 109 246 110 266 137 252 153 222 176 225 195 244 213 250 174 191 179 85
Rectangle -7500403 true true 135 80 157 96
Polygon -7500403 true true 179 85 215 147 207 164 172 102
Polygon -7500403 true true 124 84 79 144 93 160 129 96
Line -10899396 false 180 30 180 30
Rectangle -1184463 true false 161 23 177 43
Rectangle -10899396 true false 135 30 135 45
Rectangle -1184463 true false 127 28 147 48
Polygon -2674135 true false 129 74 129 58 133 75 136 61 140 73 146 60 147 76 153 64 158 76 164 64 167 77 172 64 130 59
Rectangle -16777216 true false 135 38 142 46
Rectangle -16777216 true false 165 33 172 42
Polygon -7500403 true true 93 119
Polygon -2674135 true false 170 144 167 154 170 162 165 168 165 179 166 185 166 191 160 196 160 193 158 192 163 184 167 179 166 168 161 168 159 163 154 165 154 160 160 156 161 155 167 159 170 154 178 150 180 143 173 143 173 138 169 147
Polygon -2674135 true false 130 110 128 120 134 122 134 126 131 126 128 131 128 124 129 120 126 145 131 151 132 149 134 142
Polygon -2674135 true false 166 99 157 104 165 108 167 108 175 99 176 109 169 113 166 117 161 114 153 117 160 107 167 101 165 100 163 102
Polygon -2674135 true false 138 92 131 99 125 97 130 90 130 86 127 85 127 79 128 76
Polygon -2674135 true false 136 295 133 291 129 291 126 296 133 299 135 298 117 299
Polygon -2674135 true false 122 291 104 284 94 274
Polygon -2674135 true false 103 289 111 297 115 291 106 290 101 289 106 296 112 295
Polygon -7500403 true true 210 249 198 277 214 296 203 298 187 290 181 277 197 242
Polygon -7500403 true true 114 233 103 217 91 195 84 193 77 198 76 208 76 220 81 229 87 227 91 222 95 239 101 251 110 260
Polygon -7500403 true true 214 144 257 137 267 132 279 126 282 138 277 138 285 148 284 158 269 148 270 161 279 170 268 166 252 152 206 161
Polygon -7500403 true true 52 73 81 145 93 135 64 71 69 54 66 47 52 58 46 44 41 60 52 68 33 72 41 93 45 75
Polygon -2674135 true false 61 75 62 64 71 60
Polygon -2674135 true false 56 74 60 86 53 85 52 73
Polygon -2674135 true false 47 53 52 51 51 46 45 39
Polygon -2674135 true false 268 155 271 170 275 194 275 208 283 206 286 200 282 191 281 179 281 169 278 160

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

virulent
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 210 105 195 135 165 105
Polygon -7500403 true true 108 92 93 117 104 146 138 107
Line -10899396 false 180 30 180 30
Rectangle -2674135 true false 161 23 177 43
Rectangle -10899396 true false 135 30 135 45
Rectangle -2674135 true false 127 28 147 48
Polygon -2674135 true false 129 74 129 58 133 75 136 61 140 73 146 60 147 76 153 64 158 76 164 64 167 77 172 64 130 59
Rectangle -16777216 true false 135 38 142 46
Rectangle -16777216 true false 165 33 172 42
Polygon -7500403 true true 93 119
Polygon -2674135 true false 94 117 92 127 96 126 95 135 98 133 101 142 103 150 100 145 107 148 106 143 106 139 103 134 120 135 102 140 101 128 101 121 99 122 95 120
Polygon -2674135 true false 170 144 167 154 170 162 165 168 165 179 166 185 166 191 160 196 160 193 158 192 163 184 167 179 166 168 161 168 159 163 154 165 154 160 160 156 161 155 167 159 170 154 178 150 180 143 173 143 173 138 169 147
Polygon -2674135 true false 130 110 128 120 134 122 134 126 131 126 128 131 128 124 129 120 126 145 131 151 132 149 134 142
Polygon -2674135 true false 166 99 157 104 165 108 167 108 175 99 176 109 169 113 166 117 161 114 153 117 160 107 167 101 165 100 163 102
Polygon -2674135 true false 138 92 131 99 125 97 130 90 130 86 127 85 127 79 128 76
Polygon -2674135 true false 136 295 133 291 129 291 126 296 133 299 135 298 117 299
Polygon -2674135 true false 122 291 104 284 94 274
Polygon -2674135 true false 103 289 111 297 115 291 106 290 101 289 106 296 112 295
Polygon -2674135 true false 195 105 210 120 210 120 195 135 195 120 195 135 195 150 195 135 210 135 210 120
Polygon -2674135 true false 210 120 210 105 195 120 195 135 210 105 225 105 210 105 210 120 195 135 195 135 195 105 210 120 195 120 210 105 210 135 195 135 195 135 195 120 195 105
Polygon -2674135 true false 105 75 120 90 135 60 135 60 135 75 120 75 105 75 90 105 60 120 75 105 60 105 75 105 75 90 90 90 90 75 105 75 105 75 135 90 135 90
Polygon -13840069 true false 135 75 120 75 105 75 90 60 75 60 60 90 60 90 45 105 75 90 90 75 120 60 135 60 150 75
Polygon -2674135 true false 150 75 225 105 240 90 180 75 180 75 165 75 165 75 180 75 195 75 225 90 240 90
Polygon -13840069 true false 165 75 180 75 240 90 225 105 255 105 255 105 225 90 225 90 195 90
Polygon -10899396 true false 180 60 195 60 225 30 240 30 285 45 285 60 255 45 225 45 210 75 180 60 165 60
Polygon -2674135 true false 165 75 195 75 210 60 240 60 240 75 255 90 240 90 225 75 210 75
Polygon -2674135 true false 90 45 105 60 120 75 120 60 105 60 105 45 90 45 75 75 30 30 60 75 45 75 60 75 60 60 75 60 75 45 90 45 90 45 120 60 120 60
Rectangle -10899396 true false 20 105 30 111
Rectangle -13840069 true false 260 165 270 171
Rectangle -13840069 true false 219 158 229 164
Rectangle -13840069 true false 251 117 261 123
Rectangle -13840069 true false 15 56 25 62
Rectangle -13840069 true false 48 17 58 23
Rectangle -13840069 true false 61 174 71 180
Rectangle -13840069 true false 26 150 36 156

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

zombie
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 108 92 93 117 104 146 138 107
Line -10899396 false 180 30 180 30
Rectangle -10899396 true false 161 23 177 43
Rectangle -10899396 true false 135 30 135 45
Rectangle -10899396 true false 127 28 147 48
Polygon -2674135 true false 129 74 129 58 133 75 136 61 140 73 146 60 147 76 153 64 158 76 164 64 167 77 172 64 130 59
Rectangle -16777216 true false 135 38 142 46
Rectangle -16777216 true false 165 33 172 42
Polygon -7500403 true true 93 119
Polygon -2674135 true false 94 117 92 127 96 126 95 135 98 133 101 142 103 150 100 145 107 148 106 143 106 139 103 134 99 131 102 140 101 128 101 121 99 122 95 120
Polygon -2674135 true false 170 144 167 154 170 162 165 168 165 179 166 185 166 191 160 196 160 193 158 192 163 184 167 179 166 168 161 168 159 163 154 165 154 160 160 156 161 155 167 159 170 154 178 150 180 143 173 143 173 138 169 147
Polygon -2674135 true false 130 110 128 120 134 122 134 126 131 126 128 131 128 124 129 120 126 145 131 151 132 149 134 142
Polygon -2674135 true false 166 99 157 104 165 108 167 108 175 99 176 109 169 113 166 117 161 114 153 117 160 107 167 101 165 100 163 102
Polygon -2674135 true false 138 92 131 99 125 97 130 90 130 86 127 85 127 79 128 76
Polygon -2674135 true false 136 295 133 291 129 291 126 296 133 299 135 298 117 299
Polygon -2674135 true false 122 291 104 284 94 274
Polygon -2674135 true false 103 289 111 297 115 291 106 290 101 289 106 296 112 295
@#$#@#$#@
NetLogo 6.0.4
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
