TITLE Random Strings Program
;|------------------------------------------|
;|This program generates 20 random strings--|
;|Each string contains 10 characters {A..Z}-| 
;|Next stores the stings in an array--------|  
;|Finally display the stings on screen------| 
;|With an id number ahead of them-----------|
;|------------------------------------------|

INCLUDE Irvine32.inc
	STRING_COUNT = 5
	STRING_LENGTH= 5

.data
msg_str1  BYTE "20 Random String was created by the Program",0 
msg_str2  BYTE "ID   STRING ",0 
msg_str3  BYTE "-----------------",0 
space_str4 BYTE '.', 2 DUP (' '),0

str_array BYTE STRING_COUNT DUP (STRING_LENGTH DUP(?), 0)

.code

main PROC
	call Clrscr ; clear screen 
	mov esi, OFFSET str_array 
	mov ecx, STRING_COUNT

	call GenerateRandomStringsProc

	call DisplayRandomStringsProc

	exit
main ENDP

GenerateRandomStringsProc PROC USES ecx esi eax ebx
;|------------------------------------------|
;|Generates random strings------------------| 
;|each string contains 10 characters {A..Z}-| 
;|stores the strings in an array------------| 
;|Receives: ESI points to the str_array-----| 
;|ECX = string counter----------------------| 
;|Returns:nothing---------------------------| 
;|------------------------------------------|
	call Randomize ;Initializes starting seed
L1:mov ebx, ecx ; store outer loop counter (number of strings) 
	mov ecx, STRING_LENGTH ; set inner loop counter (size of string)
	L2:mov eax, 'Z'-'A'+1 ; set randomize range 
		call RandomRange ; produce random number from 0 to EAX-1 
		add eax, 'A' ; add initial character offset 
		mov [esi], eax ; store random character to array 
		inc esi ; point to next array character 
	loop L2 ; loop until ECX=0 (size of string)
	inc esi ; point to next string in array (pass 0 char)
	mov ecx, ebx ; restore outer loop counter 
loop L1 ; loop until ECX=0 (number of strings)
		ret 
GenerateRandomStringsProc ENDP

DisplayRandomStringsProc PROC USES edx ecx eax
;|--------------------------------------|
;|Displays strings from an array--------| 
;|Receives: ESI points to the str_array-| 
;|ECX = string counter------------------| 
;|Returns: nothing----------------------|
;|--------------------------------------|

mov edx, OFFSET msg_str1 
call WriteString ;display message line1 
call Crlf ;go to next output line 
call Crlf ;go to next output line 

mov edx, OFFSET msg_str2 
call WriteString ;display message line2 
call Crlf ;go to next output line
	
mov edx, OFFSET msg_str3 
call WriteString ;display message line3 
call Crlf ;go to next output line

mov eax, 1d ; set id counter 
L1: call WriteDec ; display id counter 
	mov edx, OFFSET space_str4 
	call WriteString ; display message (spaces)
	mov edx, esi ; EDX point to current string of array 
	call WriteString ; display current string 
	call Crlf ; go to next output line
	add esi, STRING_LENGTH + 1 ; ESI point to next string of array 
	inc eax ; next id counter 
	loop L1 ; loop until ECX=0 (number of strings)
call Crlf ; go to next output line 
ret 
DisplayRandomStringsProc ENDP
END main
