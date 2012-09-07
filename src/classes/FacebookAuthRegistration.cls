global class FacebookAuthRegistration implements Auth.RegistrationHandler
{
  global User createUser(Id portalId, Auth.UserData data)
  {
    Id pId = [Select Id From Profile Where Name = 'Custom High Volume Customer Portal' Limit 1].Id;
    
    Contact c = new Contact(
      FirstName = data.firstName,
      LastName = data.lastName,
      Email = data.email,
      AccountId = '001E000000MjSSl'
    );
    insert c;
    
    return new User(
      Username = data.username + '@facebookauth.demo',
      Email = data.email,
      LastName = data.lastName,
      FirstName = data.firstName,
      Alias = data.username.length() > 8 ? data.username.substring(0, 8) : data.username,
      LanguageLocaleKey = 'en_US',
      LocaleSidKey = UserInfo.getLocale(),
      EmailEncodingKey = 'UTF-8',
      TimeZoneSidKey = 'America/Los_Angeles',
      ProfileId = pId,
      ContactId = c.Id
    );
  }

  global void updateUser(Id userId, Id portalId, Auth.UserData data)
  {
    User u = [Select Email, FirstName, LastName, Contact.Email, Contact.FirstName, Contact.LastName From User Where Id = :userId];
    u.Email = u.Contact.Email = data.email;
    u.FirstName = u.Contact.FirstName = data.firstName;
    u.LastName = u.Contact.LastName = data.lastName;
    update(u);
  }
}