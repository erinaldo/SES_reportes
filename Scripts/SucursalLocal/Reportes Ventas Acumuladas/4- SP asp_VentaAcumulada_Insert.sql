
GO
/****** Object:  StoredProcedure [dbo].[asp_VentaAcumulada_Insert]    Script Date: 26/01/2019 10:23:17 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF  EXISTS (SELECT * FROM SYS.OBJECTS WHERE TYPE = 'P' AND NAME = 'asp_VentaAcumulada_Insert')
DROP PROCEDURE asp_VentaAcumulada_Insert
GO
Create PROCEDURE [dbo].[asp_VentaAcumulada_Insert] 
	-- Add the parameters for the stored procedure here
	@fecha datetime,
	@opcion numeric(1,0)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
		declare @fechaAnt datetime
		--set @fecha='2016-02-29 00:00:00.000'
		--set @fecha=getdate()
		--set @fecha='2019-04-30 00:00:00.000'
		
		set @fecha=convert(nvarchar(4), datepart(year,@fecha) , 0)+''+right('0'+convert(nvarchar(2), datepart(month,@fecha) , 0),2)+''+right('0'+convert(nvarchar(2), datepart(day,@fecha) , 0),2)
		
		select @fechaAnt=case @opcion when 1 then  dateadd(
			day,
			( case when datepart(dw,@fecha) - datepart(dw,
		
					case  when convert(nvarchar(MAX), datepart(month,@fecha) , 0)='2' and convert(nvarchar(MAX), datepart(day,@fecha) , 0)='29' then
						cast(convert(nvarchar(MAX), datepart(year,@fecha)-1 , 0)+'-'+convert(nvarchar(MAX), datepart(month,@fecha) , 0)+'-'+convert(nvarchar(MAX), datepart(day,@fecha) -1, 0)+' 00:00:00.000' as datetime)
					else
						cast(convert(nvarchar(MAX), datepart(year,@fecha)-1 , 0)+'-'+convert(nvarchar(MAX), datepart(month,@fecha) , 0)+'-'+convert(nvarchar(MAX), datepart(day,@fecha) , 0)+' 00:00:00.000' as datetime)
					end
			
		
				)  <-3 then datepart(dw,@fecha)
					else
					datepart(dw,@fecha) - datepart(dw,
		
					case  when convert(nvarchar(MAX), datepart(month,@fecha) , 0)='2' and convert(nvarchar(MAX), datepart(day,@fecha) , 0)='29' then
						cast(convert(nvarchar(MAX), datepart(year,@fecha)-1 , 0)+'-'+convert(nvarchar(MAX), datepart(month,@fecha) , 0)+'-'+convert(nvarchar(MAX), datepart(day,@fecha) -1, 0)+' 00:00:00.000' as datetime)
					else
						cast(convert(nvarchar(MAX), datepart(year,@fecha)-1 , 0)+'-'+convert(nvarchar(MAX), datepart(month,@fecha) , 0)+'-'+convert(nvarchar(MAX), datepart(day,@fecha) , 0)+' 00:00:00.000' as datetime)
					end
			
		
				)
					end 

			),
	
			case  when convert(nvarchar(MAX), datepart(month,@fecha) , 0)='2' and convert(nvarchar(MAX), datepart(day,@fecha) , 0)='29' then
			cast(convert(nvarchar(MAX), datepart(year,@fecha)-1 , 0)+'-'+convert(nvarchar(MAX), datepart(month,@fecha) , 0)+'-'+convert(nvarchar(MAX), datepart(day,@fecha)-1 , 0)+' 00:00:00.000' as datetime)--,datepart(dw,@fecha)  --,datepart(dw,cast(convert(nvarchar(MAX), datepart(year,@fecha)-1 , 0)+'-'+convert(nvarchar(MAX), datepart(month,@fecha) , 0)+'-'+convert(nvarchar(MAX), datepart(day,@fecha) , 0)+' 00:00:00.000' as datetime))  
			else
			cast(convert(nvarchar(MAX), datepart(year,@fecha)-1 , 0)+'-'+convert(nvarchar(MAX), datepart(month,@fecha) , 0)+'-'+convert(nvarchar(MAX), datepart(day,@fecha) , 0)+' 00:00:00.000' as datetime)--,datepart(dw,@fecha)  --,datepart(dw,cast(convert(nvarchar(MAX), datepart(year,@fecha)-1 , 0)+'-'+convert(nvarchar(MAX), datepart(month,@fecha) , 0)+'-'+convert(nvarchar(MAX), datepart(day,@fecha) , 0)+' 00:00:00.000' as datetime))  
			end 
		)
		when 2 then
			cast(convert(nvarchar(MAX), datepart(year,@fecha)-1 , 0)+'-'+convert(nvarchar(MAX), datepart(month,@fecha) , 0)+'-'+convert(nvarchar(MAX), datepart(day,@fecha) , 0)+' 00:00:00.000' as datetime)
		end 
		declare @IdFolio int
		select @IdFolio=isnull(max(IdFolio),0)+1  from RPT_VentaAcumulada
		
		insert into RPT_VentaAcumulada ([IdFolio],[Tventa_Actual] ,
			[NTickets_Actual] ,
			[Pventa_Actual],
			[PArticulosXticket_Actual],
			[Tventa_Anterior],
			[NTickets_Anterior] ,
			[Pventa_Anterior],
			[PArticulosXticket_Anterior],
			[Porcentaje],
			[Fecha_Actual],
			[Fecha_Anterior],
			[Sucursal],
			[FechaInsert],
			[TVenta_AnteriorMeta])  

		(select @IdFolio, isnull(Tventa_Actual,0),isnull(NTickets_Actual,0),isnull(Pventa_Actual,0),isnull(PArticulosXticket_Actual,0),isnull(Tventa_Anterior,0),isnull(NTickets_Anterior,0),isnull(Pventa_Anterior,0),isnull(PArticulosXticket_Anterior,0),isnull((Tventa_Actual*100)/TVenta_AnteriorMeta,0) as Porcentaje,@fecha as Fecha_Actual,@fechaAnt as Fecha_Anterior,Sucursal,getdate(),TVenta_AnteriorMeta
		from

		(select 
			(select sum(t.TicketTotal)
			from Ticket as t
			where t.TicketFecha=@fecha) as Tventa_Actual,
			(select count(TicketId) from Ticket as t
			where t.TicketFecha=@fecha ) as NTickets_Actual,
			(select avg(t.TicketTotal)  
			from Ticket as t
			where t.TicketFecha=@fecha) as Pventa_Actual,
			 (
			select sum(convert(money,g.CantidadArt))/count(convert(money,g.CantidadArt)) from (select isnull(sum(isnull(td.TicketArticuloCantidad,0)),0) as CantidadArt
			from Ticket as t
				inner join TicketArticulo as td on t.TicketId=td.TicketId and t.CajaId=td.CajaId
			where t.TicketFecha=@fecha
			group by t.TicketId) as g)  as PArticulosXticket_Actual
			,
			(select sum(t.TicketTotal)  
			from Ticket as t
			where t.TicketFecha=@fechaAnt) as Tventa_Anterior,
			(select count(TicketId) from Ticket as t
			where t.TicketFecha=@fechaAnt ) as NTickets_Anterior,
			(select avg(t.TicketTotal)  
			from Ticket as t
			where t.TicketFecha=@fechaAnt) as Pventa_Anterior,
			 (
			select sum(convert(money,g.CantidadArt))/count(convert(money,g.CantidadArt)) from (select isnull(sum(isnull(td.TicketArticuloCantidad,0)),0) as CantidadArt
			from Ticket as t
				inner join TicketArticulo as td on t.TicketId=td.TicketId and t.CajaId=td.CajaId
			where t.TicketFecha=@fechaAnt
			group by t.TicketId) as g)  as PArticulosXticket_Anterior,
			(select top 1 SucursalesNombre from Ticket as t inner join caja as c on c.CajaId=t.cajaId inner join sucursales as s on s.SucursalesId=c.SucursalesId order by TicketId desc ) as Sucursal
			,(select sum(t.TicketTotal)  
			from Ticket as t
			where t.TicketFecha=@fechaAnt)*(Select (1+(ValorParametro/100)) from RPT_VentaAcumuladaIncremento where IdParametro=1) as TVenta_AnteriorMeta
			) as TG
		)

		declare @tventaa numeric(18,2)
		declare @nticketa numeric(18,2)
		declare @pventaa numeric(18,2)
		declare @pticketa numeric(18,2)
		declare @tventab numeric(18,2)
		declare @tventabm numeric(18,2)
		declare @nticketb numeric(18,2)
		declare @pventab numeric(18,2)
		declare @pticketb numeric(18,2)
		declare @porcentaje numeric(18,2)
		declare @fechaa datetime
		declare @fechab datetime
		declare @suc varchar(50)
		declare @fechains datetime

		set @tventaa=(select isnull(Tventa_Actual,0) from RPT_VentaAcumulada where IdFolio=@IdFolio)
		set @nticketa=(select isnull(NTickets_Actual,0) from RPT_VentaAcumulada where IdFolio=@IdFolio)
		set @pventaa=(select isnull(Pventa_Actual,0) from RPT_VentaAcumulada where IdFolio=@IdFolio)
		set @pticketa=(select isnull(PArticulosXticket_Actual,0) from RPT_VentaAcumulada where IdFolio=@IdFolio)
		set @tventab=(select isnull(Tventa_Anterior,0) from RPT_VentaAcumulada where IdFolio=@IdFolio)
		set @tventabm=(select isnull(TVenta_AnteriorMeta,0) from RPT_VentaAcumulada where IdFolio=@IdFolio)
		set @nticketb=(select isnull(NTickets_Anterior,0) from RPT_VentaAcumulada where IdFolio=@IdFolio)
		set @pventab=(select isnull(Pventa_Anterior,0) from RPT_VentaAcumulada where IdFolio=@IdFolio)
		set @pticketb=(select isnull(PArticulosXticket_Anterior,0) from RPT_VentaAcumulada where IdFolio=@IdFolio)
		set @porcentaje=(select isnull(Porcentaje,0) from RPT_VentaAcumulada where IdFolio=@IdFolio)
		set @fechaa=(select Fecha_Actual from RPT_VentaAcumulada where IdFolio=@IdFolio)
		set @fechab=(select Fecha_Anterior from RPT_VentaAcumulada where IdFolio=@IdFolio)
		set @suc=(select isnull(Sucursal,'') from RPT_VentaAcumulada where IdFolio=@IdFolio)
		set @fechains=(select FechaInsert from RPT_VentaAcumulada where IdFolio=@IdFolio)


		exec [SERVER-SON].SES_Reportes.dbo.SP_BSC_VentaAcumulada_Insert @tventaa,@nticketa,@pventaa,@pticketa,@tventab,@nticketb,@pventab,@pticketb,@porcentaje,@fechaa,@fechab,@suc,@fechains,@tventabm


		Select @IdFolio
END

GO
