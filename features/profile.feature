# feature/profile.feature
Feature: Settings
  I want to Change Profile data for my account: Avatar, Full name, Initials, Email and Password

Background:
 Given the following users is registered:
  | email                   | password           | full name   | Initials  |
  | nonadmin@myorg.com      | mypassword1234     | Karli Novak | KN        |
And the following file:
 | file          | size     |
 | Moon.png      | 0.5 MB   |
 | Star.png      | 0.2 MB   |
 | File.txt      | 0.2 MB   |

 Scenario: Successful navigate to profile page
   Given home page of BioSistemika Process team of a Karli Novak user
   Then I click to Avatar
   Then I click to Settings in avatar drop down menu
   Then I should  see "My profile page" of a Karli Novak user

Scenario: Unsuccessful add avatar, file is too big
  Given My profile page of a Karli Novak user
  Then I click to Avatar
  Then I click to Browse button
  And I select a Moon.png file
  Then I click to Open button
  Then I click to Upload button
  And I should see "You can upload max 0.2 MB of files at one time. Please remove one or more files and try to submit again" error message under "Avatar" field

Scenario: Unsuccessful add avatar, file is invalid
  Given My profile page of a Karli Novak user
  Then I click to Avatar
  Then I click to Browse button
  And I select a File.txt file
  Then I click to Open button
  Then I click to Upload button
  And I should see "Avatar content type is invalid" error message under "Avatar" field

Scenario: Successful add avatar
  Given My profile page of a Karli Novak user
  Then I click to Avatar
  Then I click to Browse button
  And I select a Star.png file
  Then I click to Open button
  Then I click to Upload button
  And I should see "Your account has been updated successfully" flash message

Scenario: Successful Full name Change
  Given My profile page of a Karli Novak user
  Then I click to Edit button under Full name field
  And I fill in "Novakovic"
  Then I click to Update button
  And I should see "Karli Novak Novakovic" in Full name field

Scenario: Unsuccessful Initials Change, is too long
  Given My profile page of a Karli Novak user
  Then I click to Edit button under Initials field
  And I fill in "KNOCK"
  Then I click to Update button
  And I should see "is too long (maximum is 4 characters)" flash message

Scenario: Successful Initials Change
  Given My profile page of a Karli Novak user
  Then I click to Edit button under Initials field
  And I fill in "KN"
  Then I click to Update button
  And I should see "KNKN" in Full name field

Scenario: Successful Email Change
  Given My profile page of a Karli Novak user
  Then I click to Edit button under Email field
  And I Change "nonadmin@myorg.com" with "user@myorg.com"
  And I fill in "mypassword1234" in Current password field
  Then I click to Update button
  And I should see "user@myorg.com" in Email field

Scenario: Unsuccessful Password Change, is too short
  Given My profile page of a Karli Novak user
  Then I click to Edit button under Password field
  And I fill in "mypassword1234" in Current pasword field
  And I fill in "mypass" in New pasword field
  And I fill in "mypass" in New pasword confiramtion field
  Then I click to Update button
  And I should see "is too short (minimum is 8 characters)" flash message under New password field
  And I should see "is too short (minimum is 8 characters)" flash message under New password confiramtion field

Scenario: Unsuccessful Password Change, does not match
  Given My profile page of a Karli Novak user
  Then I click to Edit button under Password field
  And I fill in "mypassword1234" in Current pasword field
  And I fill in "mypassword5678" in New pasword field
  And I fill in "mypassword56788" in New pasword confiramtion field
  Then I click to Update button
  And I should see "doesn't match Password" flash message under New password confiramtion field

Scenario: Unsuccessful Password Change, current password is invalid
  Given My profile page of a Karli Novak user
  Then I click to Edit button under Password field
  And I fill in "mypassword123" in Current pasword field
  And I fill in "mypassword5678" in New pasword field
  And I fill in "mypassword5678" in New pasword confiramtion field
  Then I click to Update button
  And I should see "is invalid" flash message under Current password field

Scenario: Successful Password Change
  Given My profile page of a Karli Novak user
  Then I click to Edit button under Password field
  And I fill in "mypassword1234" in Current pasword field
  And I fill in "mypassword5678" in New pasword field
  And I fill in "mypassword5678" in New pasword confiramtion field
  Then I click to Update button
  And I should see "XXXXX"