public class AccountContactWrapper {
	public String Name;
	public String Type;
	public String Phone;
	public String Fax;
	public String AccountNumber;
	public String Industry;
	public Decimal AnnualRevenue;
	public Integer NumberOfEmployees;
	public String Ownership;
	public String Description;
	public String Rating;
	public List<Contacts> contacts;

	public class Contacts {
		public String LastName;
		public String FirstName;
		public String Salutation;
		public String Phone;
		public String MobilePhone;
		public String Email;
		public String Title;
		public String Department;
		public String Description;
	}
	
	public static AccountContactWrapper parse(String json) {
		return (AccountContactWrapper) System.JSON.deserialize(json, AccountContactWrapper.class);
	}
}