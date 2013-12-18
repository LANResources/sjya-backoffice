#
# Admin Setup
#

lan = Organization.find_or_create_by name: 'LAN Resources'
User.find_or_create_by(email: 'nreed@biozymeinc.com') do |u|
  u.first_name = 'Nick'
  u.last_name = 'Reed'
  u.role = 'administrator'
  u.password = 'changeM3!'
  u.password_confirmation = 'changeM3!'
  u.organization_id = lan.id
end

#
# Default Organizations
#

{
  'Youth Serving Organizations' => [
    'St. Joseph Youth Alliance',
    'Heartland Foundation'
  ],
  'Youth' => [
    'Xtreme Youth Coalition',
  ],
  'Health Care Professionals' => [
    'Health & Senior Services',
    'Northwest Health'
  ],
  'Law Enforcement Agency' => [
    'Drug Strike Force',
    'Missouri Western State University Police Department',
    'St. Joseph Police Department'
  ],
  'Media' => [
    'News-Press Now'
  ],
  'Religious/Fraternal' => [
    'Journey Church',
    'David Mason'
  ],
  'Schools' => [
    'MU Extension',
    'Saint Joseph School District'
  ],
  'Government' => [
    'Childrens Division',
    "County Prosecutor's Office",
    'Probation & Parole'
  ],
  'Other Organization with Expertise in Substance Abuse' => [
    'Preferred Family Health Care',
    'St. Joseph Safety Council'
  ],
  'Parents/Caregivers' => [
    'Dan Brachman'
  ],
  'Business Community' => [
    'Alice Norris'
  ],
  'Civic/Volunteer Group' => [
    'Steve Holdenried'
  ]
}.each do |sector, orgs|
  sector_id = Sector.find_by(name: sector).try(:id)
  orgs.each{|org| Organization.create_with(sector_id: sector_id).find_or_create_by name: org }
end

#
# Default survey
#

survey = Rapidfire::Survey.create! name: "Default", active: true

survey.questions.create! section: "Impact",
                          type: "Rapidfire::Questions::Radio",
                          question_text: "How successful was the activity?",
                          answer_options: "Very Successful\r\nModerately Successful\r\nNot at All Successful",
                          validation_rules: {:presence=>nil, :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: nil,
                          follow_up_for_condition: nil,
                          allow_custom: nil,
                          help_text: ""

survey.questions.create! section: "Impact",
                          type: "Rapidfire::Questions::Radio",
                          question_text: "What major matrix box does this activity fit under?",
                          answer_options: "Planning\r\nImplementation - Environmental\r\nImplementation - Youth Asset Development\r\nImplementation - Community Education/Awareness\r\nCapacity Building/Infrastructure Sustainability\r\nAssessment\r\nEvaluation",
                          validation_rules: {:presence=>nil, :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: nil,
                          follow_up_for_condition: "",
                          allow_custom: nil,
                          help_text: ""

survey.questions.create! section: "Impact",
                          type: "Rapidfire::Questions::Checkbox",
                          question_text: "What goal in the plan does this activity impact?",
                          answer_options: "Increase community capacity to address drugs\r\nReduce non-prescribed use of prescription drugs by youth\r\nReduce rates of inappropriate over the counter drug use by youth\r\nReduce rates of youth alcohol use\r\nReduce rates of youth marijuana use\r\nReduce rates of youth tobacco use\r\nSuicide prevention\r\nIncrease community collaboration",
                          validation_rules: {:presence=>"1", :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: nil,
                          follow_up_for_condition: "",
                          allow_custom: nil,
                          help_text: "Can select more than one"

survey.questions.create! section: "Impact",
                          type: "Rapidfire::Questions::Radio",
                          question_text: "What strategy does this activity fall under?",
                          answer_options: "<strong>Provide Information (Awareness Services)</strong> to the community about Drug Free Communities, importance of preventing substance use by youth and current substance use trends in the community.\r\n<strong>Provide Social Support (Preventive Services)</strong> directly to families and young people that provide social alternatives (e.g. alcohol free community celebrations and events), skills and information needed to avoid problem behaviors.\r\n<strong>Build Skills (Capacity Services)</strong> to be the community's credible source for trustworthy information about the substance abuse.  Strong alliances with local media, educating the community about important local substance use facts, and encouraging participation and volunteerism in local prevention efforts. (e.g. training)\r\n<strong>Enhance or Reduce Access and/or Barriers</strong> through collaborative efforts with law enforcement to include party patrols, party notification systems, compliance checks, shoulder taps and operation storefront efforts that include youth leadership and guidance.\r\n<strong>Change Consequences</strong> New ordinances put in place, with incentives or disincentives.\r\n<strong>Change Physical Design of Environment</strong> primarily focuses on the Operation Storefront effort that will reduce immediate access of alcohol and tobacco by youth by requiring stores to comply with statute in terms of signage and placement of items or getting a fine.\r\n<strong>Modify/Change Policies</strong> creating policy change statewide as well as locally.",
                          validation_rules: {:presence=>"1", :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: nil,
                          follow_up_for_condition: "",
                          allow_custom: nil,
                          help_text: ""

survey.questions.create! section: "Impact",
                          type: "Rapidfire::Questions::SectorCheckbox",
                          question_text: "In what sectors did the activity occur?",
                          answer_options: "",
                          validation_rules: {:presence=>nil, :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: nil,
                          follow_up_for_condition: "",
                          allow_custom: nil,
                          help_text: "Please select all that apply"

survey.questions.create! section: "Participants/Items",
                          type: "Rapidfire::Questions::Numeric",
                          question_text: "How many items/people were involved in the activity?",
                          answer_options: "",
                          validation_rules: {:presence=>nil, :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: nil, follow_up_for_condition: "", allow_custom: nil, help_text: ""

q1 = survey.questions.create! section: "Participants/Items",
                          type: "Rapidfire::Questions::Radio",
                          question_text: "Were any of the participants members of the coalition?",
                          answer_options: "Yes\r\nNo",
                          validation_rules: {:presence=>nil, :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: nil,
                          follow_up_for_condition: "",
                          allow_custom: nil,
                          help_text: ""

survey.questions.create! section: "Participants/Items",
                          type: "Rapidfire::Questions::UserMultiSelect",
                          question_text: "List them:",
                          answer_options: "",
                          validation_rules: {:presence=>nil, :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: q1.id,
                          follow_up_for_condition: "Yes",
                          allow_custom: nil,
                          help_text: ""

survey.questions.create! section: "Participants/Items",
                          type: "Rapidfire::Questions::Checkbox",
                          question_text: "What coalition committee(s) was/were impacted by this activity?",
                          answer_options: "Common Message Committee\r\nMarketing & Media Committee\r\nPlan of Action Committee\r\nKey People Committee",
                          validation_rules: {:presence=>nil, :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: nil, follow_up_for_condition: "", allow_custom: nil, help_text: ""

q2 = survey.questions.create! section: "Participants/Items",
                          type: "Rapidfire::Questions::Checkbox",
                          question_text: "Who helped facilitate this activity?",
                          answer_options: "SJPD\r\nYouth Alliance\r\nHeartland Regional Medical Center\r\nAmeri-Corps\r\nSJSD\r\nPreferred Family Healthcare\r\nMWSU\r\nMo Career Center\r\nMOATC\r\nUniversity of MO Extension\r\nMODOT\r\nOther",
                          validation_rules: {:presence=>nil, :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: nil, follow_up_for_condition: "", allow_custom: nil,
                          help_text: "Check all that apply."

survey.questions.create! section: "Participants/Items",
                          type: "Rapidfire::Questions::Short",
                          question_text: "List the others that helped:",
                          answer_options: "",
                          validation_rules: {:presence=>nil, :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: q2.id,
                          follow_up_for_condition: "Other",
                          allow_custom: nil,
                          help_text: ""

survey.questions.create! section: "Participants/Items",
                          type: "Rapidfire::Questions::Numeric",
                          question_text: "Adult volunteer hours generated from activity?",
                          answer_options: "",
                          validation_rules: {:presence=>nil, :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: nil, follow_up_for_condition: "", allow_custom: nil, help_text: ""

survey.questions.create! section: "Participants/Items",
                          type: "Rapidfire::Questions::Numeric",
                          question_text: "Youth volunteer hours generated from activity?",
                          answer_options: "",
                          validation_rules: {:presence=>nil, :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: nil, follow_up_for_condition: "", allow_custom: nil, help_text: ""

q3 = survey.questions.create! section: "Participants/Items",
                          type: "Rapidfire::Questions::Radio",
                          question_text: "Was any technical assistance received around this activity?",
                          answer_options: "Yes\r\nNo",
                          validation_rules: {:presence=>nil, :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: nil, follow_up_for_condition: "", allow_custom: nil, help_text: ""

survey.questions.create! section: "Participants/Items",
                          type: "Rapidfire::Questions::Long",
                          question_text: "Please describe:",
                          answer_options: "",
                          validation_rules: {:presence=>nil, :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: q3.id,
                          follow_up_for_condition: "Yes",
                          allow_custom: nil, help_text: ""

survey.questions.create! section: "Media Use",
                          type: "Rapidfire::Questions::Checkbox",
                          question_text: "What media was used as a part of the activity?",
                          answer_options: "TV\r\nRadio\r\nFacebook\r\nNews Press\r\nBillboard",
                          validation_rules: {:presence=>nil, :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: nil, follow_up_for_condition: "", allow_custom: nil, help_text: ""

survey.questions.create! section: "Media Use",
                          type: "Rapidfire::Questions::Numeric",
                          question_text: "How many impressions did that media generate?",
                          answer_options: "",
                          validation_rules: {:presence=>nil, :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: nil, follow_up_for_condition: "", allow_custom: nil, help_text: ""

q4 = survey.questions.create! section: "Results",
                          type: "Rapidfire::Questions::Radio",
                          question_text: "Did the activity generate any resources?",
                          answer_options: "Yes\r\nNo",
                          validation_rules: {:presence=>nil, :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: nil, follow_up_for_condition: "", allow_custom: nil, help_text: ""

survey.questions.create! section: "Results",
                          type: "Rapidfire::Questions::Short",
                          question_text: "How much?",
                          answer_options: "",
                          validation_rules: {:presence=>nil, :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: q4.id,
                          follow_up_for_condition: "Yes",
                          allow_custom: nil, help_text: ""

survey.questions.create! section: "Results",
                          type: "Rapidfire::Questions::Short",
                          question_text: "From whom?",
                          answer_options: "",
                          validation_rules: {:presence=>nil, :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: q4.id,
                          follow_up_for_condition: "Yes",
                          allow_custom: nil, help_text: ""

q5 = survey.questions.create! section: "Results",
                          type: "Rapidfire::Questions::Checkbox",
                          question_text: "Was there a match amount created from this activity?",
                          answer_options: "Cash\r\nIn-Kind",
                          validation_rules: {:presence=>nil, :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: nil, follow_up_for_condition: "", allow_custom: nil, help_text: ""

survey.questions.create! section: "Results",
                          type: "Rapidfire::Questions::Short",
                          question_text: "Fill in cash amount:",
                          answer_options: "",
                          validation_rules: {:presence=>nil, :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: q5.id,
                          follow_up_for_condition: "Cash",
                          allow_custom: nil, help_text: ""

survey.questions.create! section: "Results",
                          type: "Rapidfire::Questions::Long",
                          question_text: "Please write in all the details:",
                          answer_options: "",
                          validation_rules: {:presence=>nil, :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: q5.id,
                          follow_up_for_condition: "In-Kind",
                          allow_custom: nil, help_text: ""

q6 = survey.questions.create! section: "Results",
                          type: "Rapidfire::Questions::Radio",
                          question_text: "Was any community change achieved from the activity?",
                          answer_options: "Yes\r\nNo",
                          validation_rules: {:presence=>nil, :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: nil, follow_up_for_condition: "", allow_custom: nil, help_text: ""

survey.questions.create! section: "Results",
                          type: "Rapidfire::Questions::Long",
                          question_text: "Please describe:",
                          answer_options: "",
                          validation_rules: {:presence=>nil, :minimum=>nil, :maximum=>nil, :greater_than_or_equal_to=>nil, :less_than_or_equal_to=>nil},
                          follow_up_for_id: q6.id,
                          follow_up_for_condition: "Yes",
                          allow_custom: nil, help_text: ""

