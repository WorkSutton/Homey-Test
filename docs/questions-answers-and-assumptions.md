# Questions and Answers

These are the questions I would have asked colleagues to ascertain what the requirements are for this ticket, that were not included in the brief description. I would ask them to the following colleauges:

 - developer(s) (existing, those leaving the project/organisation)
 - product owner(s)
 - delivery manager(s)

Q1. What is a project, what does it represent to the users?
A1. A project represents the process of delivering a piece of work for a client.

Q2. Is there a standard template for delivering a project?
A2. No, we don't have a standard template for project delivery. We do however have some standards and documentaiton of what previous developers have set as guidelines and possibly best practices here at Homey.
These will be shared with you and you should read them to familiarise yourself with these. Please ask if you have further questions

Q3. Is there a common set of project(s) that Homey delivers?
A3. I am not sure I understand the relevance of the question. Can we park it for now as I believe my correct answer is no.

Q4. Is a project made up of activities/tasks that need to be tracked?
A4. Yes, but these are not part of this phase/ticket. 

Q5. What are the various statuses that a project can have?
A5. Ah this is complex! The existing statuses we currently have in our spreadsheet are:
- Draft
- Pending
- In Progress
- Awaiting Information
- Awaiting Approval
- Approved
- Overdue
- Cancelled
- Completed

Q6. Ah that is quite a few statuses, are all of these really used or can we reduce this list?
A6. No, we must have all of these

Q7. Are there any business rules around changing status? Is this a linear flow? Can all statuses be used at any point in the projects lifecycle? e.g. can `In Progress` change to `Approved` or `Awaiting Information` or all the way back to `Draft`
A7. We would like to streamline as its been confusing for various people with many of us incorrectly using the statuses interchangeably. If you look in the spreadsheet each named tab represents a project, then on that worksheet we have columns for user, comment, date (this is autopopulated), and status. What do you suggest?

Response: You are the client. However I think if you have no current rules we should do some further design around this feature. Maybe setup a meeting with various business colleagues to determine how there really use statuses, or rather how they would like to in the new world.

If we are not migrating this spreadsheet data to the new system then maybe we can optimise for what you would like best practice to be. As opposed to taking forward the existing statuses that you have suggested have caused confusion.

I am happy to be involved in any meetings to assist with design/documentation of this. We could also spike a solution based on that/those meetings.

Client response - If we keep it simple for now and say there are no constraints, I'd like you to provide a working prototype ASAP.

Q8. Can anybody change the status of a project? Or can only specific staff members or staff roles change the status?
A8. In the existing spreadsheet, as long as you have a Office 365 login, you can make the change.

Q9. Do we need to integate with Office 365 login?
A9. As part of a future requirement we would like to have User logins, but it doens't have to integrated with Office 365. However that would be done, its well outside of my comprehension and sounds costly/time consuming!

Q10. So we don't need to provide a login feature for users?
A10. If you can do that in the very limited time then it would be a bonus. I would be fine with just having a dropdown as we do in excel that we use to select who has made the change. It cannot be blank when a user either makes a comment or changes a projects status.

Q11. Where do you want the activities (status updates and comments) to be displayed? On one main page? Or on only the projects page?
A11. Currently in the spreadsheet each project has its own worksheet (named tab)

Q12. Do you want the activities most recent first, or should this be user selectable? Options being reverse chronological or chronological. Reverse being most recent first.
A12. Oh definetly most recent first

Q13. On a typical project how many individual activities - comments and status changes - would you say is an average? I am asking as wondering if we will need a scrollable type list on a single page, or these activities displayed over several pages
A13. Ah, my business partner and I disagree on this and her staff and mine tend to do what each of us do. So 40% of my staff like to see it in one long list. But her staff (60%) take that long list and to send to clients in reports they batch up 25 entries and copy them to a Office Word document. So we will take your recommendation. If we went with a long scrollable list could we print as individual pages? See how you do for time

Q14. Oh I have another question on status. Is there a default/starting status for a new project?
A14. Yes there is, its `Draft`

Q15. You mentioned this spreadsheet that is currently used, can you provide me with a copy please?
A15. Sure, no problems, but not sure it will be useful!

Response - well I was thinking in a future iteration/delivery you might want the existing data imported. Also I wanted to get a feel for how the current system looks/works.

Q16. Can anybody create a project?
A16. Yes, we don't have any restrictions.

Q17. You said the spreadsheet has `user`, `comment`, `date` and `status`. Is there any other additional data you want us to record?
A17. No thanks.

Q18. Can comments be edited/deleted? And if so are there any rules / restrictions around editing/deleting?
A18. We don't delete any comments. Yes they can be edited.

Client response - coming back to the previous question, when I share the spreadsheet you will see the first 10 rows after the project name are reserved for a description. Could you include that too please. We don't want to loose that information!

Q19. Another questions on statuses, do you ever add to this list and how?
A19. We have Sarah our spreadsheet wizard, she does some magic to add new status. Originally we had this where anybody could type the status, but as you can imagine some of us would make spelling mistakes, or have a different view of what a status meant (which we still do).

Response - ah so do statuses get edited/deleted/archived by Sarah?
Client response - I don't think so you would need to ask Sarah. She is on holiday for the next 2 weeks, so I think just add all the statuses for now unless there is a reason not to.


## Assumptions

1. This is an MVP so while I would normally work utilising BDD/TDD, there might not be as much test coverage as I would normally aim for

2. Minimal styling - will attempt to use Tailwind CSS, but have not used it in any commercial projects personally so still learning it. Now its part of Rails 7 as a default, I believe it will become more common so is something I will be investing more time into learning.

3. Am undecided at this stage if will use a gem for the logging of changes, eg papertrail/audit type gem or if will just build a simple history table.

4. No admin features required. In time it is suggested that status items are considered for an admin type feature if the end client will not have their own development resources. If however there is ongoing support provided to the client then it may be that this could be covered under that scenario. Based on previous experiences statuses are not something that would be regularly changed. So an admin interface for this is probably overkill. YMMV (Your Milage May Vary) :-)

