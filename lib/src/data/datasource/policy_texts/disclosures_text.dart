import 'package:finskool/src/domain/model/profile/profile_info.dart';

/// Section 1 of "Finskool21 App – Compliance Documents" (7 Nov 2026), verbatim.
const disclosuresDocument = PolicyDocument(
  kind: PolicyKind.disclosures,
  title: 'Disclosures',
  subtitle: 'SEBI (Research Analysts) Regulations, 2014',
  blocks: [
    PolicyParagraph(
      'The particulars given in this Disclosure Document have been prepared '
      'in accordance with the SEBI (Research Analysts) Regulations, 2014.',
    ),
    PolicyParagraph(
      'The purpose of this document is to provide essential information about '
      'the research and recommendation services offered through the '
      'Finskool21 app, so that a prospective client or client can make an '
      'informed decision before subscribing and before investing.',
    ),
    PolicyParagraph(
      'For the purpose of this Disclosure Document, the Research Analyst is '
      'Finskool21 (hereinafter referred to as the “Research Analyst”).',
    ),
    PolicyHeading('About the Research Analyst'),
    PolicyLabel('History, present business and background'),
    PolicyParagraph(
      'The Research Analyst is registered with SEBI under Registration No. '
      'INH000022987. The registration was granted on 25 August 2025, and the '
      'firm is engaged in research and recommendation services.',
    ),
    PolicyParagraph(
      'Research and recommendations are delivered to subscribers inside the '
      'Finskool21 app through its communities (Intraday Community, Swing '
      'Alpha Community and Investor Community). The Research Analyst aligns '
      'its interests with those of the client and seeks to provide '
      'well-researched services.',
    ),
    PolicyLabel('Terms and conditions of research and recommendation services'),
    PolicyParagraph(
      'The terms and conditions of the research and recommendation services '
      'are detailed in the Terms & Conditions document in this app. Please '
      'refer to it for details.',
    ),
    PolicyLabel('Disciplinary history'),
    PolicyParagraph(
      'There are no pending material litigations or legal proceedings, '
      'findings of inspections or investigations for which action has been '
      'taken or initiated by any regulatory authority against the Research '
      'Analyst, its associates or relatives.',
    ),
    PolicyLabel('Details of associates'),
    PolicyParagraph('No associates.'),
    PolicyHeading(
      'Disclosures with respect to research and recommendation '
      'services',
    ),
    PolicyBullets([
      'The Research Analyst or his associate or relative may have a financial '
          'interest, or actual or beneficial ownership of one per cent or '
          'more, in the securities recommended, in their personal portfolio '
          'at the end of the month immediately preceding the date of the '
          'recommendation or public appearance. Where this applies, it is '
          'disclosed with that recommendation in the app.',
      'There are no actual or potential conflicts of interest arising from '
          'any connection of the Research Analyst, his associate or relative '
          'to, or association with, any issuer of products or securities, '
          'including any material information or facts that might compromise '
          'objectivity or independence. Any such conflict of interest will be '
          'disclosed to the client as and when it arises.',
      'The Research Analyst or his associate or relative has no connection or '
          'association of any sort with any issuer of products or securities '
          'recommended in the app.',
      'The Research Analyst or his associates have not received any '
          'remuneration or consideration from the products or securities '
          'recommended in the app.',
      'The Research Analyst or his associates have not received any '
          'compensation from the subject company in the past 12 months.',
      'The Research Analyst or his associates have not managed or co-managed '
          'a public offering of the subject company in the past 12 months.',
      'The Research Analyst or his associates have not received any '
          'compensation for investment banking, merchant banking or '
          'brokerage services from the subject company in the past 12 months.',
      'The Research Analyst or his associates have received any compensation '
          'for products or services other than investment banking, merchant '
          'banking or brokerage services from the subject company in the '
          'past 12 months.',
      'The Research Analyst or his associates have not received any '
          'compensation or other benefits from the subject company or a '
          'third party in connection with the research recommendations.',
      'The Research Analyst or his associates have not received any '
          'compensation for products or services from the subject company in '
          'the past 12 months.',
      'The subject company is not, and was not, a client of the Research '
          'Analyst or his associates during the 12 months preceding the date '
          'of the recommendation.',
      'The Research Analyst or his associates have not served as an officer, '
          'director or employee of the subject company.',
      'The Research Analyst has not been engaged in market-making activity '
          'for the subject company.',
    ]),
  ],
);
