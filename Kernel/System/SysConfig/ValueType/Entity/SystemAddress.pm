# --
# Copyright (C) 2021 Znuny GmbH, https://znuny.org/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::SysConfig::ValueType::Entity::SystemAddress;

## nofilter(TidyAll::Plugin::Znuny::Perl::ParamObject)

use strict;
use warnings;

use parent qw(Kernel::System::SysConfig::ValueType::Entity);

our @ObjectDependencies = (
    'Kernel::System::SystemAddress',
    'Kernel::System::Web::Request',
);

=head1 NAME

Kernel::System::SysConfig::ValueType::Entity::SystemAddress - System configuration system address entity type backend.

=head1 PUBLIC INTERFACE

=head2 new()

Create an object. Do not use it directly, instead use:

    use Kernel::System::ObjectManager;
    local $Kernel::OM = Kernel::System::ObjectManager->new();
    my $EntityTypeObject = $Kernel::OM->Get('Kernel::System::SysConfig::ValueType::Entity::SystemAddress');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

sub EntityValueList {
    my ( $Self, %Param ) = @_;

    my $SystemAddressObject = $Kernel::OM->Get('Kernel::System::SystemAddress');

    my %SystemAddresses = $SystemAddressObject->SystemAddressList(
        Valid => 1,
    );

    my @Result = map { $SystemAddresses{$_} } sort keys %SystemAddresses;

    return @Result;
}

sub EntityLookupFromWebRequest {
    my ( $Self, %Param ) = @_;

    my $ParamObject         = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $SystemAddressObject = $Kernel::OM->Get('Kernel::System::SystemAddress');

    my $SystemAddressID = $ParamObject->GetParam( Param => 'ID' );
    return if !$SystemAddressID;

    my %SystemAddress = $SystemAddressObject->SystemAddressGet(
        ID => $SystemAddressID,
    );
    return if !%SystemAddress;

    return $SystemAddress{Name};
}

1;
