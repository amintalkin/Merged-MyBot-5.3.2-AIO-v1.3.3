; #FUNCTION# ====================================================================================================================
; Name ..........: eightFingerPinWheelLeft
; Description ...: Contains function to set up vectors for eight finger pinwheel left deployment
; Syntax ........:
; Parameters ....:
; Return values .: None
; Author ........: LunaEclipse(January, 2016)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

; Set up the vectors to deploy troops
Func eightFingerPinWheelLeftVectors(ByRef $dropVectors, $listInfoDeploy)
	If Not IsArray($dropVectors) Or Not IsArray($listInfoDeploy) Then Return
	
	ReDim $dropVectors[UBound($listInfoDeploy)][8]
	
	Local $kind, $waveNumber, $waveCount, $position, $remainingWaves, $waveDropAmount, $dropAmount, $barPosition
	Local $startPoint[2] = [0, 0], $endPoint[2] = [0, 0]
	Local $aDeployButtonPositions = getUnitLocationArray()
	Local $unitCount = unitCountArray()

	For $i = 0 To UBound($listInfoDeploy) - 1
		$kind = $listInfoDeploy[$i][0]
		$waveNumber = $listInfoDeploy[$i][2]
		$waveCount = $listInfoDeploy[$i][3]
		$position = $listInfoDeploy[$i][4]
		$remainingWaves = ($waveCount - $waveNumber) + 1
		$barPosition = $aDeployButtonPositions[$kind]

		If IsNumber($kind) And $barPosition <> -1 And $position = 0 Then
			$waveDropAmount = calculateDropAmount($unitCount[$kind], $remainingWaves, $position)
			$unitCount[$kind] -= $waveDropAmount

			; Top Left - Left Half
			$dropAmount = Ceiling($waveDropAmount / 8)
			If $dropAmount > 0 Then
				$startPoint = convertToPoint($TopLeft[2][0], $TopLeft[2][1])
				$endPoint = convertToPoint($TopLeft[0][0], $TopLeft[0][1])
				addVector($dropVectors, $i, 0, $startPoint, $endPoint, $dropAmount)
				$waveDropAmount -= $dropAmount
			EndIf

			; Top Left - Right Half
			$dropAmount = Ceiling($waveDropAmount / 7)
			If $dropAmount > 0 Then
				$startPoint = convertToPoint($TopLeft[4][0], $TopLeft[4][1])
				$endPoint = convertToPoint($TopLeft[2][0], $TopLeft[2][1])
				addVector($dropVectors, $i, 1, $startPoint, $endPoint, $dropAmount + 1)
				$waveDropAmount -= $dropAmount
			EndIf

			; Top Right - Left Half
			$dropAmount = Ceiling($waveDropAmount / 6)
			If $dropAmount > 0 Then
				$startPoint = convertToPoint($TopRight[2][0], $TopRight[2][1])
				$endPoint = convertToPoint($TopRight[0][0], $TopRight[0][1])
				addVector($dropVectors, $i, 2, $startPoint, $endPoint, $dropAmount)
				$waveDropAmount -= $dropAmount
			EndIf

			; Top Right - Right Half
			$dropAmount = Ceiling($waveDropAmount / 5)
			If $dropAmount > 0 Then
				$startPoint = convertToPoint($TopRight[4][0], $TopRight[4][1])
				$endPoint = convertToPoint($TopRight[2][0], $TopRight[2][1])
				addVector($dropVectors, $i, 3, $startPoint, $endPoint, $dropAmount + 1)
				$unitCount[$kind] -= $dropAmount
			EndIf

			; Bottom Right - Left Half
			$dropAmount = Ceiling($waveDropAmount / 4)
			If $dropAmount > 0 Then
				$startPoint = convertToPoint($BottomRight[0][0], $BottomRight[0][1])
				$endPoint = convertToPoint($BottomRight[2][0], $BottomRight[2][1])
				addVector($dropVectors, $i, 4, $startPoint, $endPoint, $dropAmount)
				$waveDropAmount -= $dropAmount
			EndIf

			; Bottom Right - Right Half
			$dropAmount = Ceiling($waveDropAmount / 3)
			If $dropAmount > 0 Then
				$startPoint = convertToPoint($BottomRight[2][0], $BottomRight[2][1])
				$endPoint = convertToPoint($BottomRight[4][0], $BottomRight[4][1])
				addVector($dropVectors, $i, 5, $startPoint, $endPoint, $dropAmount + 1)
				$waveDropAmount -= $dropAmount
			EndIf

			; Bottom Left - Left Half
			$dropAmount = Ceiling($waveDropAmount / 2)
			If $dropAmount > 0 Then
				$startPoint = convertToPoint($BottomLeft[0][0], $BottomLeft[0][1])
				$endPoint = convertToPoint($BottomLeft[2][0], $BottomLeft[2][1])
				addVector($dropVectors, $i, 6, $startPoint, $endPoint, $dropAmount)
				$waveDropAmount -= $dropAmount
			EndIf

			; Bottom Left - Right Half
			$dropAmount = $waveDropAmount
			If $dropAmount > 0 Then
				$startPoint = convertToPoint($BottomLeft[2][0], $BottomLeft[2][1])
				$endPoint = convertToPoint($BottomLeft[4][0], $BottomLeft[4][1])
				addVector($dropVectors, $i, 7, $startPoint, $endPoint, $dropAmount + 1)				
				$waveDropAmount -= $dropAmount
			EndIf
		EndIf
	Next
EndFunc   ;==>eightFingerPinWheelLeftVectors