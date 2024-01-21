#include "system.h"
#include "altera_avalon_pio_regs.h"
#include "altera_avalon_timer_regs.h"
#include "altera_avalon_timer.h"
#include "sys/alt_stdio.h"
#include "sys/alt_sys_init.h"
#include "alt_types.h"
#include "io.h"
#include "unistd.h"
#include "stdio.h"
#include "sys/alt_irq.h"
#include "opencores_i2c_regs.h"
#include "opencores_i2c.h"

#define DATAX0 0x32
#define DATAX1 0x33
#define DATAY0 0x34
#define DATAY1 0x35
#define DATAZ0 0x36
#define DATAZ1 0x37

#define addroffsetx 0x1E
#define addroffsety 0x1F
#define addroffsetz 0x20

__int16_t DATAX = 0;
__int16_t DATAY = 0;
__int16_t DATAZ = 0;

__int16_t data[3] = { 0,0,0 };

__uint8_t cpt = 0;

//offset 0
#define offsetx0  0x9
#define offsety0  0xfffffff6
#define offsetz0  0xfffffff0

//offset final 
#define offsetxf 0xff
#define offsetyf 0x03
#define offsetzf 0x04

//valeur des segments
__uint8_t seg0, seg1, seg2, seg3, seg4;
__uint8_t signe=0;



void acc_write(alt_u32 add, __int8_t data)
{
	I2C_start(OPENCORES_I2C_0_BASE, 0x1d, 0);
	I2C_write(OPENCORES_I2C_0_BASE, add, 0);
	I2C_write(OPENCORES_I2C_0_BASE, data, 1);
}

__int8_t acc_read(alt_u32 add)
{
	I2C_start(OPENCORES_I2C_0_BASE, 0x1d, 0);
	I2C_write(OPENCORES_I2C_0_BASE, add, 0);
	I2C_start(OPENCORES_I2C_0_BASE, 0x1d, 1);
	return I2C_read(OPENCORES_I2C_0_BASE, 1);
}

void segment()
{

	if (data[cpt] < 0) signe = 1; else signe = 0;
	seg4 = data[cpt] / 10000;
	seg3 = (data[cpt] % 10000) / 1000;
	seg2 = (data[cpt] % 1000) / 100;
	seg1 = (data[cpt] % 100) / 10;
	seg0 = data[cpt] % 10;
}

static void irqhandler_timer(void* context, alt_u32 id)
{
	DATAX = (acc_read(DATAX1) << 8 | acc_read(DATAX0));
	DATAY = (acc_read(DATAY1) << 8 | acc_read(DATAY0));
	DATAZ = (acc_read(DATAZ1) << 8 | acc_read(DATAZ0));
	if (DATAX & 0x8000) DATAX = -(0xFFFF - DATAX + 1);
	if (DATAY & 0x8000) DATAY = -(0xFFFF - DATAY + 1);
	if (DATAZ & 0x8000) DATAZ = -(0xFFFF - DATAZ + 1);
	data[0] = DATAX * 3.9;
	data[1] = DATAY * 3.9;
	data[2] = DATAZ * 3.9;
	segment();
	IOWR_ALTERA_AVALON_PIO_DATA(PIO0_7SEG_BASE, seg0);
	IOWR_ALTERA_AVALON_PIO_DATA(PIO1_7SEG_BASE, seg1);
	IOWR_ALTERA_AVALON_PIO_DATA(PIO2_7SEG_BASE, seg2);
	IOWR_ALTERA_AVALON_PIO_DATA(PIO3_7SEG_BASE, seg3);
	IOWR_ALTERA_AVALON_PIO_DATA(PIO4_7SEG_BASE, seg4);
	if (signe == 1)
	{
		IOWR_ALTERA_AVALON_PIO_DATA(PIO5_7SEG_BASE, 15);
	}
	else
	{
		IOWR_ALTERA_AVALON_PIO_DATA(PIO5_7SEG_BASE, 0);
	}
	
	IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_0_BASE, 0x01);
}

static void irqhandler_bp(void* context, alt_u32 id)
{
	cpt++;
	cpt = cpt % 3;
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIOBP_BASE, 0x01);
}




int main(void)
{
	I2C_init(OPENCORES_I2C_0_BASE, TIMER_0_FREQ, 400000);
	acc_write(addroffsetx, 0);
	acc_write(addroffsety, 0);
	acc_write(addroffsetz, 0);
	acc_write(addroffsetx, offsetxf);
	acc_write(addroffsety, offsetyf);
	acc_write(addroffsetz, offsetzf);
	alt_irq_register(TIMER_0_IRQ, NULL, irqhandler_timer);
	IOWR_ALTERA_AVALON_PIO_IRQ_MASK(PIOBP_BASE, 0x01);
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIOBP_BASE, 0x01);
	alt_irq_register(PIOBP_IRQ, NULL, (void*) irqhandler_bp);
	while (1);
	return(0);
}