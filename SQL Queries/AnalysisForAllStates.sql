--Inpatients Column Analysis 
	--Yearly Analysis
	select [Year],sum(Total_Discharges) as Total_Discharges_Yearly from Staging_Inpatients group by [year] order by [Year]
	select [Year],sum(Average_Total_Payments) as Average_Total_Payments_Yearly from Staging_Inpatients group by [year] order by [Year]
	select [Year],sum(Average_Medicare_Payments) as Average_Medicare_Payments_Yearly from Staging_Inpatients group by [year] order by [Year]
	select [Year],sum(Average_Covered_Charges) as Average_Covered_Charges_Yearly from Staging_Inpatients group by [year] order by [Year]
	--StateWise Analysis
	select [Provider_State],sum(Total_Discharges) as Total_Discharges_State from Staging_Inpatients group by [Provider_State] order by [Provider_State] DESC
	select [Provider_State],sum(Average_Total_Payments) as Average_Total_Payments_State from Staging_Inpatients group by [Provider_State] order by [Provider_State] DESC
	select [Provider_State],sum(Average_Medicare_Payments) as Average_Medicare_Payments_State from Staging_Inpatients group by [Provider_State] order by [Provider_State] DESC
	select [Provider_State],sum(Average_Covered_Charges) as Average_Covered_Charges_State from Staging_Inpatients group by [Provider_State] order by [Provider_State] DESC

--Outpatients APC Column Analysis
	--StateWise Analysis
	select [Provider_State],sum(Beneficiaries) as TotalBenefitted_MEDICARE from Staging_OutpatientsAPC group by [Provider_State] order by TotalBenefitted_MEDICARE Desc
	select [Provider_State],sum(Average_Medicare_Allowed_Amount) as TotalAverageMedicareAllowedAmount from Staging_OutpatientsAPC group by [Provider_State] order by TotalAverageMedicareAllowedAmount Desc
	select [Provider_State],sum(Average_Estimated_Total_Submitted_Charges) as TotalAverageEstimatedSubmittedCharges from Staging_OutpatientsAPC group by [Provider_State] order by TotalAverageEstimatedSubmittedCharges Desc
	select [Provider_State],sum(Average_Medicare_Outlier_Amount) as TotalAverageMedicareOutlierAmount from Staging_OutpatientsAPC group by [Provider_State] order by TotalAverageMedicareOutlierAmount Desc
	select [Provider_State],sum(Average_Medicare_Payment_Amount) as TotalAverageMedicarePaymentAmount from Staging_OutpatientsAPC group by [Provider_State] order by TotalAverageMedicarePaymentAmount Desc
	--YearWise Analysis
	select [YEAR],sum(Beneficiaries) as TotalBenefitted_MEDICARE_Yearly from Staging_OutpatientsAPC group by [YEAR] order by [YEAR] 
	select [YEAR],sum(Average_Medicare_Allowed_Amount) as TotalAverageMedicareAllowedAmount_Yearly from Staging_OutpatientsAPC group by [YEAR] order by [YEAR] 
	select [YEAR],sum(Average_Estimated_Total_Submitted_Charges) as TotalAverageEstimatedSubmittedCharges_Yearly from Staging_OutpatientsAPC group by [YEAR] order by [YEAR] 
	select [YEAR],sum(Average_Medicare_Outlier_Amount) as TotalAverageMedicareOutlierAmount_Yearly from Staging_OutpatientsAPC group by [YEAR] order by [YEAR] 
	select [YEAR],sum(Average_Medicare_Payment_Amount) as TotalAverageMedicarePaymentAmount_Yearly from Staging_OutpatientsAPC group by [YEAR] order by [YEAR] 

--Outpatients HCPCSAPC Column Analysis
	--StateWise Analysis
	select [State],sum(Beneficiaries) as TotalBenefittedbyHCPCSServices from Staging_OutpatientsHCPCSAPC group by [State] order by TotalBenefittedbyHCPCSServices Desc
	select [State],sum(Average_Medicare_Allowed_Amount) as TotalAverageMedicareAllowedAmount from Staging_OutpatientsHCPCSAPC group by [State] order by TotalAverageMedicareAllowedAmount Desc
	select [State],sum(Average_Medicare_Outlier_Amount) as TotalAverageMedicareOutlierAmount from Staging_OutpatientsHCPCSAPC group by [State] order by TotalAverageMedicareOutlierAmount Desc
	select [State],sum(Average_Medicare_Payment_Amount) as TotalAverageMedicarePaymentAmount from Staging_OutpatientsHCPCSAPC group by [State] order by TotalAverageMedicarePaymentAmount Desc
	select [State],sum(Average_Total_Submitted_Charges) as TotalAverageSubmittedCharges from Staging_OutpatientsHCPCSAPC group by [State] order by TotalAverageSubmittedCharges Desc
	--YearWise Analysis
	select [YEAR],sum(Beneficiaries) as TotalBenefittedbyHCPCSServices_Yearly from Staging_OutpatientsHCPCSAPC group by [YEAR] order by [YEAR] 
	select [YEAR],sum(Average_Medicare_Allowed_Amount) as TotalAverageMedicareAllowedAmount_Yearly from Staging_OutpatientsHCPCSAPC group by [YEAR] order by [YEAR] 
	select [YEAR],sum(Average_Medicare_Outlier_Amount) as TotalAverageMedicareOutlierAmount_Yearly from Staging_OutpatientsHCPCSAPC group by [YEAR] order by [YEAR] 
	select [YEAR],sum(Average_Medicare_Payment_Amount) as TotalAverageMedicarePaymentAmount_Yearly from Staging_OutpatientsHCPCSAPC group by [YEAR] order by [YEAR] 
	select [YEAR],sum(Average_Total_Submitted_Charges) as TotalAverageSubmittedCharges_Yearly from Staging_OutpatientsHCPCSAPC group by [YEAR] order by [YEAR] 

--Hospital Payment and Performance Column Analysis
select [State],sum(Denominator) as TotalPatientsEligibleinPaymentMeasurement from Staging_HospitalPaymentPerformance group by [State] order by TotalPatientsEligibleinPaymentMeasurement DESC
select [State],sum(Payment) as TotalPayment from Staging_HospitalPaymentPerformance group by [State] order by TotalPayment Desc
select [State],sum(Lower_estimate) as LowerEstimate_State from Staging_HospitalPaymentPerformance group by [State] order by [LowerEstimate_State] desc
select [State],sum(Higher_estimate) as HigherEstimate_State from Staging_HospitalPaymentPerformance group by [State] order by [HigherEstimate_State] desc