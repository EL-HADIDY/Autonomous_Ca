
	
	AREA MYDATA, DATA, READONLY

BIT_MASK EQU 0x333333
B_BIT_MASK EQU 0x8888888


;--------------- Base Addresses -----------;
RCC_BASE 	EQU 0X40021000 
GPIOA_BASE  EQU 0X40010800
GPIOB_BASE  EQU 0X40010C00
GPIOC_BASE  EQU 0X40011000
PWR_BASE 	EQU 0x40007000
RTC_BASE	EQU 0x40002800
AFIO_BASE   EQU 0x40010000
EXTI_BASE   EQU 0x40010400
NVIC_ISER0  EQU 0xE000E100
NVIC_ISER1	EQU 0xE000E104
ADC1_BASE	EQU 0x40012400
TIM2_BASE   EQU 0x40000000      ; Base address for TIM2
	
;--------------- Port Enabler -----------;
RCC_APB2ENR EQU RCC_BASE + 0X18
RCC_APB1ENR EQU RCC_BASE + 0x1C
RCC_BDCR	EQU RCC_BASE + 0x20
RCC_CSR		EQU RCC_BASE + 0x24

;--------------- Power control -----------;
PWR_CR		EQU PWR_BASE + 0x000

;--------------- GPIO Pin Config -----------;
GPIOA_CRL   EQU GPIOA_BASE + 0X00
GPIOB_CRL   EQU GPIOB_BASE + 0X00
GPIOC_CRL   EQU GPIOC_BASE + 0X00

GPIOA_CRH   EQU GPIOA_BASE + 0X04
GPIOB_CRH   EQU GPIOB_BASE + 0X04
GPIOC_CRH   EQU GPIOC_BASE + 0X04
	
GPIOA_IDR   EQU GPIOA_BASE + 0X08
GPIOB_IDR   EQU GPIOB_BASE + 0X08
GPIOC_IDR   EQU GPIOC_BASE + 0X08

GPIOA_ODR   EQU GPIOA_BASE + 0X0C
GPIOB_ODR   EQU GPIOB_BASE + 0X0C
GPIOC_ODR   EQU GPIOC_BASE + 0X0C

;---------------RTC Pin Config -----------;
RTC_CRL		EQU RTC_BASE + 0x04
RTC_CRH		EQU RTC_BASE + 0x00
RTC_PRLL	EQU RTC_BASE + 0x0C
RTC_CNTH	EQU RTC_BASE + 0x18
RTC_CNTL    EQU RTC_BASE + 0x1C
RTC_ALRH	EQU RTC_BASE + 0x20
RTC_ALRL 	EQU RTC_BASE + 0x24
RTC_PRLH	EQU RTC_BASE + 0x08
;---------------EXTI Pin Config -----------;
AFIO_EXTICR4 EQU AFIO_BASE + 0x14
EXTI_IMR     EQU EXTI_BASE + 0x00
EXTI_RTSR    EQU EXTI_BASE + 0x08
EXTI_FTSR	 EQU EXTI_BASE + 0x0C
EXTI_PR      EQU EXTI_BASE + 0x14
	
ADC_SR		EQU ADC1_BASE + 0x00
ADC1_SMPR2	EQU ADC1_BASE + 0x10
ADC_SQR3	EQU ADC1_BASE + 0x34
ADC1_CR1	EQU ADC1_BASE + 0x04
ADC1_CR2	EQU ADC1_BASE + 0x08
TIM2_CR1        EQU TIM2_BASE + 0x00 ; Control Register 1
TIM2_PSC        EQU TIM2_BASE + 0x28 ; Prescaler
TIM2_ARR        EQU TIM2_BASE + 0x2C ; Auto-Reload Register
TIM2_DIER       EQU TIM2_BASE + 0x0C ; DMA/Interrupt Enable Register
TIM2_SR         EQU TIM2_BASE + 0x10 ; Status Register

;GPIOC_BASE EQU 0x40020800
;GPIOC_PUPDR EQU GPIOC_BASE + 0x0C
;GPIOC_IDR EQU GPIOC_BASE + 0x10

RST_PIN EQU 8
CS_PIN EQU 9
RS_PIN EQU 10
WR_PIN EQU 11
RD_PIN EQU 12


;AFIO_BASE		EQU		0x40010000   ;in TA's code but we dont know why
AFIO_MAPR	EQU		AFIO_BASE + 0x04   ;in TA's code but we dont know why

INTERVAL EQU 0x186004		;just a number to perform the delay. this number takes roughly 1 second to decrement until it reaches 0


;the following are pins connected from the TFT to our EasyMX board
;RD = PE10		Read pin	--> to read from touch screen input 
;WR = PE11		Write pin	--> to write data/command to display
;RS = PE12		Command pin	--> to choose command or data to write
;CS = PE15		Chip Select	--> to enable the TFT, lol	(active low)
;RST= PE8		Reset		--> to reset the TFT (active low)
;D0-7 = PE0-7	Data BUS	--> Put your command or data on this bus




	
	AREA	MYCODE, CODE, READONLY
		
	EXPORT __main
ENTRY
	
__main FUNCTION
	
	
	bl GPIO_ENABLE_PORT_C



superloop

	
	
	b superloop

	ENDFUNC

; HELPER DELAYS IN THE SYSTEM, YOU CAN USE THEM DIRECTLY


;##########################################################################################################################################
delay_1_second
	;this function just delays for 1 second
	PUSH {R8, LR}
	LDR r8, =INTERVAL
delay_loop
	SUBS r8, #1
	CMP r8, #0
	BGE delay_loop
	POP {R8, PC}
;##########################################################################################################################################




;##########################################################################################################################################
delay_half_second
	;this function just delays for half a second
	PUSH {R8, LR}
	LDR r8, =INTERVAL
delay_loop1
	SUBS r8, #2
	CMP r8, #0
	BGE delay_loop1

	POP {R8, PC}
;##########################################################################################################################################


;##########################################################################################################################################
delay_milli_second
	;this function just delays for a millisecond
	PUSH {R8, LR}
	LDR r8, =INTERVAL
delay_loop2
	SUBS r8, #1000
	CMP r8, #0
	BGE delay_loop2

	POP {R8, PC}
;##########################################################################################################################################



;##########################################################################################################################################
delay_10_milli_second
	;this function just delays for 10 millisecondS
	PUSH {R8, LR}
	LDR r8, =INTERVAL
delay_loop3
	SUBS r8, #100
	CMP r8, #0
	BGE delay_loop3

	POP {R8, PC}
;##########################################################################################################################################
delay_2_second
	;this function just delays for 10 millisecondS
	PUSH {R8, LR}
	LDR r8, =INTERVAL
delay_loop5
	SUBS r8, #2
	CMP r8, #0
	BGE delay_loop5
	
	


	POP {R8, PC}


;==================GPIO_PORT_ENABLER=====================;
GPIO_ENABLE_PORT_A	FUNCTION
	PUSH{R0-R12, LR}
	ldr r0, =RCC_APB2ENR
    ldr r1, [r0]
	mov r2,#1
    orr r1, r1, r2, lsl #2  ; Enable GPIOA clock
    str r1, [r0]
	POP{R0-R12, PC}
	ENDFUNC

GPIO_ENABLE_PORT_B	FUNCTION
	PUSH{R0-R12, LR}
	ldr r0, =RCC_APB2ENR
    ldr r1, [r0]
	mov r2,#1
    orr r1, r1, r2, lsl #3  ; Enable GPIOA clock
    str r1, [r0]
	POP{R0-R12, PC}
	ENDFUNC
; enable function of port C
GPIO_ENABLE_PORT_C	FUNCTION
	PUSH{R0-R12, LR}
	ldr r0, =RCC_APB2ENR
    ldr r1, [r0]
	mov r2,#1
    orr r1, r1, r2, lsl #4  ; Enable GPIOA clock
    str r1, [r0]
	POP{R0-R12, PC}
	ENDFUNC
;====================================================;
