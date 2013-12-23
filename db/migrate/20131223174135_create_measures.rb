class CreateMeasures < ActiveRecord::Migration
  def up
    create_table :measures do |t|
      t.string :description
      t.string :link
      t.references :document
      t.references :source

      t.timestamps
    end

    sources = {}
    Source.all.each{ |s| sources[s.short_name] = s.id }

    Measure.create! [
      { 
        description: 'Emergency room use for alcohol-related disorders to persons under 21 yrs of age',
        source_id: sources['HH']
      },
      {
        description: 'Juvenile law violations (rate per 1000)',
        source_id: sources['JO']
      },
      {
        description: 'Juvenile cases filed',
        source_id: sources['JO'],
        link: 'http://www.courts.mo.gov/page.jsp?id=296'
      },
      {
        description: 'Youth who have ever used alcohol',
        source_id: sources['MSS']
      },
      {
        description: 'Youth past 30 days use of alcohol - by grade and in total',
        source_id: sources['MSS']
      },
      {
        description: 'Youth who believe there is risk/harm to using alcohol - by grade and in total',
        source_id: sources['MSS']
      },
      {
        description: 'Youth who perceive parental disapproval of use of alcohol - by grade and in total',
        source_id: sources['MSS']
      },
      {
        description: 'If one of your best friends offered you alcohol to drink, would you drink it - by grade and in total',
        source_id: sources['MSS']
      },
      {
        description: 'How wrong do you feel it would be for you to have a drink of any type of alcohol - by grade and in total',
        source_id: sources['MSS']
      },
      {
        description: 'If you wanted to get some alcohol how easy would it be for you to get some? - by grade and in total',
        source_id: sources['MSS']
      },
      {
        description: 'Number of compliance checks performed',
        source_id: sources['SJPD']
      },
      {
        description: 'Compliance rates of retailers selling to minors',
        source_id: sources['SJPD']
      },
      {
        description: 'Citations for purchase/possession of intoxicating liquor by a minor from a retail store',
        source_id: sources['SJPD']
      },
      {
        description: 'Number of arrests for minors in possession - <= 17',
        source_id: sources['SJPD']
      },
      {
        description: 'Number of arrests for minors in possession - 18 to 20',
        source_id: sources['SJPD']
      },
      {
        description: 'Number participating in MIP classes',
        source_id: sources['SJPD']
      },
      {
        description: 'Number of businesses penalized for failing compliance check',
        source_id: sources['SJPD']
      },
      {
        description: 'Number of RBS trainings',
        source_id: sources['SJPD']
      },
      {
        description: 'Number of people trained in RBS',
        source_id: sources['SJPD']
      },
      {
        description: 'Penalties for use of fake IDs',
        source_id: sources['SJPD']
      },
      {
        description: 'Number of party patrols',
        source_id: sources['SJPD']
      },
      {
        description: 'School suspensions due to drugs - ISS',
        source_id: sources['SJPD']
      },
      {
        description: 'School suspensions due to drugs - OSS',
        source_id: sources['SJPD']
      },
      {
        description: 'Number of media impressions in radio',
        source_id: sources['YA']
      },
      {
        description: 'Number of media impressions in TV',
        source_id: sources['YA']
      },
      {
        description: 'Number of media impressions in Newspress',
        source_id: sources['YA']
      },
      {
        description: 'Number of media impressions in billboards',
        source_id: sources['YA']
      },
      {
        description: 'Number of media impressions on Facebook',
        source_id: sources['YA']
      },
      {
        description: 'Open rate of constant contact',
        source_id: sources['YA']
      },
      {
        description: 'Number of community changes',
        source_id: sources['YA']
      },
      {
        description: 'Number of community changes by sector - Business',
        source_id: sources['YA']
      },
      {
        description: 'Number of community changes by sector - Education',
        source_id: sources['YA']
      },
      {
        description: 'Number of community changes by sector - Government',
        source_id: sources['YA']
      },
      {
        description: 'Number of community changes by sector - Health Care',
        source_id: sources['YA']
      },
      {
        description: 'Number of community changes by sector - Law Enforcement',
        source_id: sources['YA']
      },
      {
        description: 'Number of community changes by sector - Media',
        source_id: sources['YA']
      },
      {
        description: 'Number of community changes by sector - Parents/Caregivers',
        source_id: sources['YA']
      },
      {
        description: 'Number of community changes by sector - Faith',
        source_id: sources['YA']
      },
      {
        description: 'Number of community changes by sector - Volunteer/Civic Groups',
        source_id: sources['YA']
      },
      {
        description: 'Number of community changes by sector - Youth',
        source_id: sources['YA']
      },
      {
        description: 'Number of community changes by sector - Youth Serving Agencies',
        source_id: sources['YA']
      },
      {
        description: 'Number of community changes by sector - General Community',
        source_id: sources['YA']
      },
      {
        description: 'Number of community and coalition trainings',
        source_id: sources['YA']
      },
      {
        description: 'Number attending community and coalition trainings',
        source_id: sources['YA']
      },
      {
        description: 'Number of contacts in the Safe Home Directory',
        source_id: sources['YA']
      },
      {
        description: 'Pounds of RX take backs',
        source_id: sources['YA']
      },
      {
        description: 'Number of new policies approved',
        source_id: sources['YA']
      },
      {
        description: 'Number of partnerships',
        source_id: sources['YA']
      }
    ]
  end

  def down
    drop_table :measures
  end
end
