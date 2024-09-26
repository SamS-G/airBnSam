CREATE TABLE IF NOT EXISTS "user" (
  "ID" BigInt NOT NULL,
  user_type_id Integer NOT NULL,
  user_status_id Integer NOT NULL,
  preference_id BigInt DEFAULT NULL,
  language_id Integer DEFAULT NULL,
  firstname VarChar(255) NOT NULL,
  lastname VarChar(255) NOT NULL,
  avatar Bytea DEFAULT NULL,
  email VarChar(255) NOT NULL,
  password VarChar(128) NOT NULL,
  phone_number VarChar(128) NOT NULL,
  street_number Integer DEFAULT NULL,
  street_number_complement VarChar(128) DEFAULT NULL,
  street_name VarChar(255) DEFAULT NULL,
  city VarChar(255) DEFAULT NULL,
  zip_code VarChar(255) DEFAULT NULL,
  longitude Decimal DEFAULT NULL,
  latitude Decimal DEFAULT NULL,
    CONSTRAINT pk_user PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS enum_user_type (
  "ID" BigInt NOT NULL,
  label VarChar(255) NOT NULL,
  description Text DEFAULT NULL,
    CONSTRAINT pk_type_user PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS "order" (
  "ID" BigInt NOT NULL,
  user_id BigInt NOT NULL,
  property_id BigInt NOT NULL,
  payment_id BigInt NOT NULL,
  status_id Integer NOT NULL,
  arrival_date Timestamp With Time Zone NOT NULL,
  departure_date Timestamp With Time Zone NOT NULL,
  price_per_unit Numeric(10, 4),
  booking_ref VarChar(255),
  total_travelers Integer NOT NULL,
  total_childs Integer DEFAULT NULL,
  total_adult Integer DEFAULT NULL,
  tax_amount Decimal(10, 4) DEFAULT NULL,
    CONSTRAINT pk_booking PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS enum_user_status (
  "ID" BigInt NOT NULL,
  label VarChar(255) NOT NULL,
  description Text DEFAULT NULL,
    CONSTRAINT pk_enum_status PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS property (
  "ID" BigInt NOT NULL,
  characteristic_id BigInt NOT NULL,
  user_id BigInt NOT NULL,
  is_bookable Boolean DEFAULT NULL,
  street_number VarChar(255) DEFAULT NULL,
  address_complement VarChar(255) DEFAULT NULL,
  street VarChar(255) DEFAULT NULL,
  city VarChar(255) DEFAULT NULL,
  zip_code VarChar(255) DEFAULT NULL,
  long Double Precision DEFAULT NULL,
  lat Double Precision DEFAULT NULL,
  price_peer_night Numeric(10, 4) DEFAULT NULL,
  availability_id BigInt DEFAULT NULL,
    CONSTRAINT pk_property PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS property_characteristic (
  "ID" BigInt NOT NULL,
  type_id BigInt NOT NULL,
  area Integer NOT NULL,
  room_numbers Integer DEFAULT NULL,
  floor VarChar(255) DEFAULT NULL,
  max_child_traveler Integer NOT NULL,
  max_adult_traveler Integer NOT NULL,
    CONSTRAINT pk_property_characteristic PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS service (
  "ID" BigInt NOT NULL,
  category_id BigInt NOT NULL,
  label VarChar(255) NOT NULL,
  description Text DEFAULT NULL,
  price Numeric(5, 2),
  price_unit VarChar(255) DEFAULT NULL,
    CONSTRAINT pk_service PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS equipment (
  "ID" BigInt NOT NULL,
  label VarChar(255) NOT NULL,
  description Text DEFAULT NULL,
  category_id BigInt NOT NULL,
    CONSTRAINT pk_equipment PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS property_service (
  "ID" BigInt NOT NULL,
  property_id BigInt NOT NULL,
  service_id BigInt NOT NULL,
    CONSTRAINT pk_property_service PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS property_equiment (
  "ID" BigInt NOT NULL,
  property_id BigInt NOT NULL,
  equipment_id BigInt NOT NULL,
    CONSTRAINT pk_property_equiment PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS enum_category (
  "ID" BigInt NOT NULL,
  label VarChar(255) NOT NULL,
  description Text DEFAULT NULL,
    CONSTRAINT pk_category PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS property_type (
  "ID" BigInt NOT NULL,
  label VarChar(255) NOT NULL,
  description Text DEFAULT NULL,
    CONSTRAINT pk_property_type PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS traveler (
  "ID" BigInt NOT NULL,
  user_id BigInt NOT NULL,
  birth_date Timestamp With Time Zone DEFAULT NULL,
  nationality VarChar(255) DEFAULT NULL,
    CONSTRAINT pk_traveler PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS host (
  "ID" BigInt NOT NULL,
  user_id BigInt NOT NULL,
  is_professional Boolean DEFAULT NULL,
  siret VarChar(255) DEFAULT NULL,
  company_name VarChar(255) DEFAULT NULL,
    CONSTRAINT pk_host PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS enum_language (
  "ID" BigInt NOT NULL,
  label Char(255) NOT NULL,
  description Text,
    CONSTRAINT pk_enum_language PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS user_preference (
  "ID" BigInt NOT NULL,
  user_id BigInt NOT NULL,
  tax_area_id Integer NOT NULL,
  message_notif Boolean DEFAULT NULL,
  reservation_notif Boolean DEFAULT NULL,
  review_notif Boolean DEFAULT NULL,
  push Boolean DEFAULT NULL,
    CONSTRAINT pk_user_preference PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS review (
  "ID" BigInt NOT NULL,
  review_type_id BigInt NOT NULL,
  order_id BigInt NOT NULL,
  star_number Integer NOT NULL,
  label VarChar(255) NOT NULL,
  "comment" Text NOT NULL,
    CONSTRAINT pk_review PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS enum_review_type (
  "ID" BigInt NOT NULL,
  label VarChar(255) NOT NULL,
  description Text,
    CONSTRAINT pk_enum_review_type PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS message (
  "ID" BigInt NOT NULL,
  user_id BigInt NOT NULL,
  chat_id BigInt NOT NULL,
  label VarChar(255) DEFAULT NULL,
  content Text DEFAULT NULL,
  is_read Boolean DEFAULT NULL,
  send_at Timestamp With Time Zone NOT NULL,
  sending_status_id Integer NOT NULL,
    CONSTRAINT pk_message PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS chat (
  "ID" BigInt NOT NULL,
  created_at Timestamp With Time Zone NOT NULL,
  subject VarChar(255) DEFAULT NULL,
  number_message Integer NOT NULL,
  last_message_date Timestamp With Time Zone NOT NULL,
  read_by_all Boolean DEFAULT NULL,
  archived Boolean DEFAULT NULL,
  participant JSON NOT NULL,
    CONSTRAINT pk_chat PRIMARY KEY ("ID")
);
COMMENT ON COLUMN chat.created_at
  IS 'chat starting date';
COMMENT ON COLUMN chat.number_message
  IS 'total messages';
COMMENT ON COLUMN chat.last_message_date
  IS 'date of last message';
COMMENT ON COLUMN chat.read_by_all
  IS 'is read by everyone ?';
COMMENT ON COLUMN chat.archived
  IS 'is the chat archived ?';
CREATE TABLE IF NOT EXISTS notification (
  "ID" BigInt NOT NULL,
  user_id BigInt NOT NULL,
  notif_requester_id BigInt NOT NULL,
  sending_status_id Integer NOT NULL,
  is_read Boolean DEFAULT NULL,
  content VarChar(255),
  send_at Timestamp With Time Zone,
    CONSTRAINT pk_notification PRIMARY KEY ("ID")
);
COMMENT ON COLUMN notification.user_id
  IS 'user who received the notification';
CREATE TABLE IF NOT EXISTS enum_notification_requester (
  "ID" BigInt NOT NULL,
  label VarChar(255) NOT NULL,
  description Text DEFAULT NULL,
    CONSTRAINT pk_enum_notification_sender PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS enum_order_status (
  "ID" BigInt NOT NULL,
  label VarChar(255) NOT NULL,
  description Text DEFAULT NULL,
    CONSTRAINT pk_enum_booking_status PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS email (
  "ID" BigInt NOT NULL,
  sender_id BigInt NOT NULL,
  sender_email VarChar(255) NOT NULL,
  recipient_id BigInt NOT NULL,
  recipient_email VarChar(255) NOT NULL,
  sending_status_id Integer NOT NULL,
  object VarChar(255) DEFAULT NULL,
  content Text NOT NULL,
  sending_date Timestamp With Time Zone NOT NULL,
    CONSTRAINT pk_email PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS enum_sending_status (
  "ID" BigInt NOT NULL,
  label VarChar(255) NOT NULL,
  description Text DEFAULT NULL,
    CONSTRAINT pk_enum_sending_status PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS payment (
  "ID" BigInt NOT NULL,
  order_id BigInt NOT NULL,
  payment_method_id Integer NOT NULL,
  transaction_service_id BigInt NOT NULL,
  currency_id Integer NOT NULL,
  amount Numeric(10, 4) NOT NULL,
  payment_date Timestamp With Time Zone NOT NULL,
  meta VarChar(255),
  details VarChar(255),
  billing_adress VarChar(255),
    CONSTRAINT pk_payment PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS enum_currency_type (
  "ID" Integer NOT NULL,
  label VarChar(255) NOT NULL,
  description Text,
    CONSTRAINT pk_enum_currency_type PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS enum_payment_status (
  "ID" Integer NOT NULL,
  label VarChar(255) NOT NULL,
  description Text DEFAULT NULL,
    CONSTRAINT pk_enum_payment_status PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS payment_paypal (
  "ID" BigInt NOT NULL,
  payment_id BigInt NOT NULL,
  paypal_email VarChar(255) NOT NULL,
  paypal_transaction_id VarChar(255) NOT NULL,
  paypal_status VarChar(255) NOT NULL,
  error_msg VarChar(255) DEFAULT NULL,
  charges Numeric(10, 4) DEFAULT NULL,
    CONSTRAINT pk_paypal_payment PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS enum_payment_method (
  "ID" BigInt NOT NULL,
  label VarChar(255) NOT NULL,
  description Text DEFAULT NULL,
    CONSTRAINT pk_enum_payment_type PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS payment_credit_card (
  "ID" BigInt NOT NULL,
  payment_id BigInt NOT NULL,
  card_number Integer NOT NULL,
  card_holder VarChar(255) NOT NULL,
  expiration_date Timestamp With Time Zone NOT NULL,
  transaction_status_id Integer NOT NULL,
  transaction_date Timestamp With Time Zone NOT NULL,
  error_msg VarChar(255),
  charges Numeric(10, 4),
    CONSTRAINT pk_credit_card PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS transaction_status (
  "ID" BigInt NOT NULL,
  label VarChar(255) NOT NULL,
  description Text DEFAULT NULL,
    CONSTRAINT pk_transaction_status PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS payment_stripe (
  "ID" BigInt NOT NULL,
  payment_id BigInt NOT NULL,
  transaction_status_id Integer NOT NULL,
  payment_method_id Integer NOT NULL,
  stripe_token VarChar(255) NOT NULL,
  transaction_date Timestamp With Time Zone NOT NULL,
  error_msg VarChar(255) DEFAULT NULL,
  stripe_transaction_id VarChar(255) NOT NULL,
  charges Numeric(10, 4) DEFAULT NULL,
    CONSTRAINT pk_stripe PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS payment_bank_account (
  "ID" BigInt NOT NULL,
  payment_id BigInt NOT NULL,
  transaction_id VarChar(255) NOT NULL,
  operation_type_id Integer NOT NULL,
  transaction_date Timestamp With Time Zone NOT NULL,
  bank_account_id BigInt NOT NULL,
  charges Numeric(10, 4),
    CONSTRAINT pk_bank_account_payment PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS enum_operation_type (
  "ID" BigInt NOT NULL,
  label VarChar(255) NOT NULL,
  description Text DEFAULT NULL,
    CONSTRAINT pk_enum_operation_type PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS bank_account (
  "ID" BigInt NOT NULL,
  user_id BigInt NOT NULL,
  currency_id Integer NOT NULL,
  account_number Integer NOT NULL,
  account_owner_name VarChar(255) NOT NULL,
  "RIB" VarChar(60) NOT NULL,
  "IBAN" VarChar(60) NOT NULL,
  "BIC" VarChar(60) NOT NULL,
    CONSTRAINT pk_bank_account PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS bank_order (
  "ID" BigInt NOT NULL,
  bank_account_id BigInt NOT NULL,
  invoice_id Integer NOT NULL,
  bank_order_number Integer NOT NULL,
  bank_order_emission_date Timestamp With Time Zone NOT NULL,
  bank_order_valid Boolean,
    CONSTRAINT pk_bank_order PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS refund (
  "ID" BigInt NOT NULL,
  invoice_id BigInt NOT NULL,
  refund_date Timestamp With Time Zone NOT NULL,
  refund_method_id Integer NOT NULL,
  refund_reason_id Integer NOT NULL,
  refund_request_date Timestamp With Time Zone NOT NULL,
  refund_state VarChar(255) NOT NULL,
  refund_charges Numeric(10, 4) DEFAULT NULL,
    CONSTRAINT pk_refund PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS enum_refund_reason (
  "ID" Integer NOT NULL,
  label VarChar(255) NOT NULL,
  description Text DEFAULT NULL,
    CONSTRAINT pk_enum_refund_reason PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS invoice (
  "ID" BigInt NOT NULL,
  order_id Integer NOT NULL,
  invoice_number VarChar(255) NOT NULL,
  invoice_date Timestamp With Time Zone NOT NULL,
  due_date Timestamp With Time Zone NOT NULL,
  invoice_status_id Integer NOT NULL,
    CONSTRAINT pk_invoice PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS enum_invoice_status (
  "ID" BigInt NOT NULL,
  label VarChar(255),
  description Text DEFAULT NULL,
    CONSTRAINT pk_enum_invoice_status PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS property_availability (
  "ID" BigInt NOT NULL,
  property_id BigInt NOT NULL,
  start_date Timestamp With Time Zone NOT NULL,
  end_date Timestamp With Time Zone,
    CONSTRAINT pk_property_availability PRIMARY KEY ("ID")
);
CREATE TABLE IF NOT EXISTS enum_tax_area (
  "ID" Integer NOT NULL,
  label VarChar(255) NOT NULL,
  percent_tax_rate VarChar(255) NOT NULL,
  description Text DEFAULT NULL,
    CONSTRAINT pk_enum_tax_area PRIMARY KEY ("ID")
);
ALTER TABLE "user" ADD CONSTRAINT "userID" UNIQUE 
  ("ID")
  NOT DEFERRABLE;

ALTER TABLE "user" ADD CONSTRAINT fk_user_type_user FOREIGN KEY
  (user_type_id) REFERENCES enum_user_type () MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE "user" ADD CONSTRAINT fk_user_type_user2 FOREIGN KEY
  (user_type_id) REFERENCES enum_user_type ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE "user" ADD CONSTRAINT fk_user_enum_status FOREIGN KEY
  (user_status_id) REFERENCES enum_user_status () MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE "user" ADD CONSTRAINT fk_user_enum_status4 FOREIGN KEY
  (user_status_id) REFERENCES enum_user_status ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE "user" ADD CONSTRAINT fk_user_property FOREIGN KEY
  ("ID") REFERENCES property ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE "user" ADD CONSTRAINT fk_user_enum_language23 FOREIGN KEY
  () REFERENCES enum_language ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE "user" ADD CONSTRAINT fk_user_user_preference FOREIGN KEY
  (preference_id) REFERENCES user_preference ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE "user" ADD CONSTRAINT fk_user_notification35 FOREIGN KEY
  () REFERENCES notification ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE "user" ADD CONSTRAINT fk_user_email38 FOREIGN KEY
  () REFERENCES email ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE "user" ADD CONSTRAINT fk_user_enum_language FOREIGN KEY
  (language_id) REFERENCES enum_language ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE enum_user_type ADD CONSTRAINT fk_type_user_user FOREIGN KEY
  () REFERENCES "user" ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE "order" ADD CONSTRAINT fk_booking_booking5 FOREIGN KEY
  () REFERENCES "order" () MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE "order" ADD CONSTRAINT fk_order_user FOREIGN KEY
  (user_id) REFERENCES "user" ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE "order" ADD CONSTRAINT fk_order_property FOREIGN KEY
  (property_id) REFERENCES property ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE "order" ADD CONSTRAINT fk_booking_enum_status FOREIGN KEY
  (status_id) REFERENCES enum_user_status ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE "order" ADD CONSTRAINT fk_order_enum_order_status FOREIGN KEY
  (status_id) REFERENCES enum_order_status ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE property ADD CONSTRAINT fk_property_property7 FOREIGN KEY
  () REFERENCES property ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE property ADD CONSTRAINT fk_property_property_characteristic FOREIGN KEY
  (characteristic_id) REFERENCES property_characteristic ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE property ADD CONSTRAINT fk_property_use FOREIGN KEY
  (user_id) REFERENCES "user" ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE property ADD CONSTRAINT fk_property_property20 FOREIGN KEY
  () REFERENCES property ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE property ADD CONSTRAINT fk_property_property_availability FOREIGN KEY
  (availability_id) REFERENCES property_availability ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE property_characteristic ADD CONSTRAINT fk_property_characteristic_property_type FOREIGN KEY
  (type_id) REFERENCES property_type ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE service ADD CONSTRAINT fk_service_eum_category FOREIGN KEY
  (category_id) REFERENCES enum_category ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE equipment ADD CONSTRAINT fk_equipment_equipment18 FOREIGN KEY
  () REFERENCES equipment ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE equipment ADD CONSTRAINT fk_equipment_eum_category FOREIGN KEY
  (category_id) REFERENCES enum_category ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE property_service ADD CONSTRAINT fk_property_service_service FOREIGN KEY
  (service_id) REFERENCES service ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE property_service ADD CONSTRAINT fk_property_service_equipment13 FOREIGN KEY
  () REFERENCES equipment ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE property_service ADD CONSTRAINT fk_property_service_property FOREIGN KEY
  (property_id) REFERENCES property ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE property_equiment ADD CONSTRAINT fk_property_equiment_equipment FOREIGN KEY
  (equipment_id) REFERENCES equipment ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE property_equiment ADD CONSTRAINT fk_property_equiment_property FOREIGN KEY
  (property_id) REFERENCES property ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE traveler ADD CONSTRAINT fk_traveler_user FOREIGN KEY
  (user_id) REFERENCES "user" ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE host ADD CONSTRAINT fk_host_user FOREIGN KEY
  (user_id) REFERENCES "user" ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE user_preference ADD CONSTRAINT fk_user_preference_enum_tax_area FOREIGN KEY
  (tax_area_id) REFERENCES enum_tax_area () MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE user_preference ADD CONSTRAINT fk_user_preference_enum_tax_area76 FOREIGN KEY
  (tax_area_id) REFERENCES enum_tax_area ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE review ADD CONSTRAINT fk_review_order FOREIGN KEY
  () REFERENCES "order" ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE review ADD CONSTRAINT fk_review_enum_review_type FOREIGN KEY
  (review_type_id) REFERENCES enum_review_type ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE message ADD CONSTRAINT fk_message_chat FOREIGN KEY
  (chat_id) REFERENCES chat ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE message ADD CONSTRAINT fk_message_user FOREIGN KEY
  (user_id) REFERENCES "user" ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE message ADD CONSTRAINT fk_message_enum_sending_status FOREIGN KEY
  (sending_status_id) REFERENCES enum_sending_status ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE notification ADD CONSTRAINT fk_notification_user FOREIGN KEY
  (user_id) REFERENCES "user" ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE notification ADD CONSTRAINT fk_notification_enum_notification_sender FOREIGN KEY
  () REFERENCES enum_notification_requester ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE notification ADD CONSTRAINT fk_notification_user36 FOREIGN KEY
  () REFERENCES "user" ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE notification ADD CONSTRAINT fk_notification_enum_sending_status FOREIGN KEY
  (sending_status_id) REFERENCES enum_sending_status ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE email ADD CONSTRAINT fk_email_user FOREIGN KEY
  (sender_id, recipient_id) REFERENCES "user" ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE email ADD CONSTRAINT fk_email_enum_sending_status FOREIGN KEY
  (sending_status_id) REFERENCES enum_sending_status ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE email ADD CONSTRAINT fk_email_email78 FOREIGN KEY
  () REFERENCES email ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE email ADD CONSTRAINT fk_email_sender_user FOREIGN KEY
  (sender_id) REFERENCES "user" ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE email ADD CONSTRAINT fk_email_recipient_user FOREIGN KEY
  (recipient_id) REFERENCES "user" ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment ADD CONSTRAINT fk_payment_enum_currency_type FOREIGN KEY
  (currency_id) REFERENCES enum_currency_type ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment ADD CONSTRAINT fk_payment_enum_payment_status FOREIGN KEY
  () REFERENCES enum_payment_status ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment ADD CONSTRAINT fk_payment_user FOREIGN KEY
  () REFERENCES "user" ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment ADD CONSTRAINT fk_payment_order FOREIGN KEY
  () REFERENCES "order" ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment ADD CONSTRAINT fk_payment_enum_payment_method FOREIGN KEY
  (payment_method_id) REFERENCES enum_payment_method ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment ADD CONSTRAINT fk_payment_paypal FOREIGN KEY
  (transaction_service_id) REFERENCES payment_paypal ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment ADD CONSTRAINT fk_payment_credit_card50 FOREIGN KEY
  () REFERENCES payment_credit_card () MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment ADD CONSTRAINT fk_payment_credit_card FOREIGN KEY
  (transaction_service_id) REFERENCES payment_credit_card () MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment ADD CONSTRAINT fk_payment_credit_card56 FOREIGN KEY
  (transaction_service_id) REFERENCES payment_credit_card ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment ADD CONSTRAINT fk_payment_stripe FOREIGN KEY
  (transaction_service_id) REFERENCES payment_stripe ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment ADD CONSTRAINT fk_payment_bank_account_payment FOREIGN KEY
  (transaction_service_id) REFERENCES payment_bank_account ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment_paypal ADD CONSTRAINT fk_paypal_payment_payment FOREIGN KEY
  (payment_id) REFERENCES payment ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment_paypal ADD CONSTRAINT fk_paypal_payment_payment46 FOREIGN KEY
  (payment_id) REFERENCES payment ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment_paypal ADD CONSTRAINT fk_paypal_transaction_status FOREIGN KEY
  (paypal_status) REFERENCES transaction_status ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment_credit_card ADD CONSTRAINT fk_credit_card_payment FOREIGN KEY
  (payment_id) REFERENCES payment ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment_credit_card ADD CONSTRAINT fk_credit_card_transaction_status FOREIGN KEY
  (transaction_status_id) REFERENCES transaction_status ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment_stripe ADD CONSTRAINT fk_stripe_payment FOREIGN KEY
  (payment_id) REFERENCES payment ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment_stripe ADD CONSTRAINT fk_stripe_transaction_status FOREIGN KEY
  (transaction_status_id) REFERENCES transaction_status ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment_stripe ADD CONSTRAINT fk_stripe_enum_payment_method FOREIGN KEY
  (payment_method_id) REFERENCES enum_payment_method ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment_bank_account ADD CONSTRAINT fk_bank_account_payment_enum_operation_type FOREIGN KEY
  (operation_type_id) REFERENCES enum_operation_type ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment_bank_account ADD CONSTRAINT fk_bank_account_payment_payment FOREIGN KEY
  (payment_id) REFERENCES payment ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment_bank_account ADD CONSTRAINT fk_bank_account_payment_bank_account FOREIGN KEY
  (bank_account_id) REFERENCES bank_account ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment_bank_account ADD CONSTRAINT fk_payment_bank_account_enum_operation_type76 FOREIGN KEY
  () REFERENCES enum_operation_type ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE payment_bank_account ADD CONSTRAINT fk_payment_bank_account_enum_operation_type FOREIGN KEY
  (operation_type_id) REFERENCES enum_operation_type ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE bank_account ADD CONSTRAINT fk_bank_account_payment FOREIGN KEY
  (user_id) REFERENCES payment ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE bank_account ADD CONSTRAINT fk_bank_account_user FOREIGN KEY
  (user_id) REFERENCES "user" ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE bank_account ADD CONSTRAINT fk_bank_account_enum_currency_type FOREIGN KEY
  (currency_id) REFERENCES enum_currency_type ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE bank_order ADD CONSTRAINT fk_bank_order_bank_account_payment FOREIGN KEY
  (bank_account_id) REFERENCES payment_bank_account ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE bank_order ADD CONSTRAINT fk_bank_order_invoice FOREIGN KEY
  (invoice_id) REFERENCES invoice ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE refund ADD CONSTRAINT fk_refund_enum_payment_method FOREIGN KEY
  (refund_method_id) REFERENCES enum_payment_method ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE refund ADD CONSTRAINT fk_refund_enum_refund_reason FOREIGN KEY
  (refund_reason_id) REFERENCES enum_refund_reason ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE invoice ADD CONSTRAINT fk_invoice_enum_invoice_status FOREIGN KEY
  (invoice_status_id) REFERENCES enum_invoice_status ("ID") MATCH FULL
  NOT DEFERRABLE;

ALTER TABLE invoice ADD CONSTRAINT fk_invoice_order FOREIGN KEY
  (order_id) REFERENCES "order" ("ID") MATCH FULL
  NOT DEFERRABLE;

