import 'package:finskool/src/domain/model/profile/profile_info.dart';

/// Section 2 of "Finskool21 App – Compliance Documents" (7 Nov 2026).
const investorCharterDocument = PolicyDocument(
  kind: PolicyKind.investorCharter,
  title: 'Investor charter',
  subtitle: 'Your rights, our commitments',
  blocks: [
    PolicyHeading('A. Vision and mission statements for investors'),
    PolicyParagraph('Vision: Invest with knowledge & safety.'),
    PolicyParagraph(
      'Mission: Every investor should be able to invest in the right '
      'investment products based on their needs, manage and monitor them to '
      'meet their goals, access reports, and enjoy financial wellness.',
    ),
    PolicyHeading('B. Details of business transacted by the Research Analyst'),
    PolicyBullets([
      'Publish research reports based on the research activities of the RA.',
      'Provide an independent, unbiased view on securities.',
      'Offer unbiased recommendations, disclosing financial interests in '
          'recommended securities.',
      'Provide research recommendations based on analysis of publicly '
          'available information and observations.',
      'Conduct annual audits.',
      'Ensure advertisements follow SEBI’s Advertisement Code for Research '
          'Analysts.',
      'Maintain records of interactions with all clients (including '
          'prospective clients) where any conversation related to research '
          'services has taken place.',
    ]),
    PolicyHeading('C. Details of services provided to investors'),
    PolicyLabel('Onboarding of clients'),
    PolicyBullets([
      'Share the terms and conditions of research services.',
      'Complete KYC of fee-paying clients.',
    ]),
    PolicyLabel('Disclosure to clients'),
    PolicyBullets([
      'Provide material information to help clients make informed decisions '
          '(business activity, disciplinary history, risks, conflicts of '
          'interest).',
      'Disclose the use of Artificial Intelligence tools in research '
          'services.',
      'Disclose conflicts of interest when distributing third-party research '
          'reports.',
      'Disclose conflicts of interest between research and other activities.',
    ]),
    PolicyLabel('Other commitments'),
    PolicyBullets([
      'Distribute research reports without discrimination.',
      'Maintain confidentiality until reports are public.',
      'Respect client data privacy.',
      'Disclose service timelines and adhere to them.',
      'Provide clear guidance and caution for complex or high-risk financial '
          'products.',
      'Treat all clients with honesty and integrity.',
      'Keep client information confidential unless legally required or with '
          'client consent.',
    ]),
    PolicyHeading('D. Grievance redressal mechanism'),
    PolicyLabel('With the Research Analyst'),
    PolicyBullets([
      'Investors may approach the Research Analyst directly: email '
          'support@finskool21.com or call +91 92113 09647.',
      'Grievances should be resolved within 21 days of receipt.',
    ]),
    PolicyLabel('On SEBI platforms'),
    PolicyBullets([
      'SCORES 2.0 (web-based centralised grievance redressal system): '
          'scores.sebi.gov.in. First review: RAASB (Research Analyst '
          'Administration and Supervisory Body). Second review: SEBI.',
      'Email to RAASB’s designated email ID.',
    ]),
    PolicyLinks([
      InfoDocument(title: 'SCORES 2.0', url: 'https://scores.sebi.gov.in/'),
    ]),
    PolicyLabel('SMARTODR platform'),
    PolicyBullets([
      'If unsatisfied, investors may use SMARTODR (smartodr.in) for online '
          'conciliation or arbitration.',
    ]),
    PolicyLinks([InfoDocument(title: 'SMARTODR', url: 'https://smartodr.in/')]),
    PolicyLabel('Physical complaints'),
    PolicyParagraph(
      'Office of Investor Assistance and Education, Securities and Exchange '
      'Board of India, SEBI Bhavan, Plot No. C4-A, ‘G’ Block, Bandra-Kurla '
      'Complex, Bandra (E), Mumbai – 400 051',
    ),
    PolicyHeading('E. Rights of investors'),
    PolicyBullets([
      'Right to privacy and confidentiality',
      'Right to transparent practices',
      'Right to fair and equitable treatment',
      'Right to adequate information',
      'Right to initial and continuing disclosure',
      'Right to fair and true advertisement',
      'Right to awareness of service parameters and timelines',
      'Right to be heard and timely redressal',
      'Right to exit financial products or services as per agreed terms',
      'Right to clear guidance for high-risk or complex products',
      'Additional rights for vulnerable consumers (e.g., differently abled)',
      'Right to provide feedback',
      'Right against coercive or one-sided clauses in financial agreements',
    ]),
    PolicyHeading('F. Expectations from investors (responsibilities)'),
    PolicyLabel('Do’s'),
    PolicyBullets([
      'Always deal with SEBI-registered Research Analysts.',
      'Verify a valid SEBI registration certificate (list of registered RAs).',
      'Pay attention to disclosures in research reports.',
      'Pay only via banking channels (or CeFCoM if applicable) and keep '
          'receipts.',
      'Review research recommendations before investing.',
      'Ask questions and clear doubts with the RA.',
      'Seek guidance for complex or high-risk products.',
      'Know your right to stop availing RA services at any time (as per '
          'terms).',
      'Provide feedback on services.',
      'Reject any clause contravening regulations.',
      'Report RAs offering assured or guaranteed returns.',
    ]),
    PolicyLinks([
      InfoDocument(
        title: 'List of SEBI-registered Research Analysts',
        url: 'https://www.sebi.gov.in/intermediaries.html',
      ),
    ]),
    PolicyLabel('Don’ts'),
    PolicyBullets([
      'Do not provide funds for investment to the RA.',
      'Don’t fall prey to misleading ads or market rumours.',
      'Don’t get attracted to discounts, gifts or incentives from RAs.',
      'Don’t share trading, demat or bank login credentials with the RA.',
    ]),
  ],
);
